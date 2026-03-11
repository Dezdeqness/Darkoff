import 'package:darkoff/data/local/dao/item_db_mapper.dart';
import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/domain/entities/item_category_info.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:drift/drift.dart';

class ItemsDao {
  ItemsDao({
    required AppDatabase db,
    required ItemDbMapper mapper,
  })  : _db = db,
        _mapper = mapper;

  final AppDatabase _db;
  final ItemDbMapper _mapper;

  Future<void> insertAllItems(List<ItemDetailEntity> items) async {
    await _db.transaction(() async {
      await clearAll();
      await _insertCategories(items);

      for (var i = 0; i < items.length; i += 500) {
        final chunk = items.skip(i).take(500).toList();
        await _insertItemChunk(chunk);
      }
    });
  }

  Future<List<ItemEntity>> getAllItems() async {
    final rows = await (_db.select(_db.items)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
    return rows.map(_mapper.toItemEntity).toList();
  }

  Future<List<ItemEntity>> getItemsByCategoryNames(
      List<String> categoryNames) async {
    if (categoryNames.isEmpty) return getAllItems();

    final query = _db.select(_db.items).join([
      innerJoin(
        _db.itemCategories,
        _db.itemCategories.itemId.equalsExp(_db.items.id),
      ),
      innerJoin(
        _db.categories,
        _db.categories.id.equalsExp(_db.itemCategories.categoryId),
      ),
    ])
      ..where(_db.categories.normalizedName.isIn(categoryNames))
      ..orderBy([OrderingTerm.asc(_db.items.name)]);

    final rows = await query.get();
    final seen = <String>{};
    return rows
        .map((row) => _mapper.toItemEntity(row.readTable(_db.items)))
        .where((item) => seen.add(item.id))
        .toList();
  }

  Future<ItemDetailEntity?> getItemDetailById(String id) async {
    final itemRow = await (_db.select(_db.items)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    if (itemRow == null) return null;

    final results = await Future.wait([
      _fetchCategories(id),
      _fetchHandbookCategoryIds(id),
      _fetchPrices(id),
      _fetchContainedItems(id),
    ]);

    return _mapper.toItemDetailEntity(
      itemRow,
      categories: results[0] as List<ItemCategoryInfo>,
      handbookCategoryIds: results[1] as List<String>,
      sellFor: (results[2] as Map<String, List<ItemPriceInfo>>)['sell']!,
      buyFor: (results[2] as Map<String, List<ItemPriceInfo>>)['buy']!,
      containsItems: results[3] as List<ContainedItem>,
    );
  }

  Future<int> getItemCount() async {
    final count = _db.items.id.count();
    final query = _db.selectOnly(_db.items)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<void> clearAll() async {
    await _db.delete(_db.itemContainedItems).go();
    await _db.delete(_db.itemPrices).go();
    await _db.delete(_db.itemHandbookCategories).go();
    await _db.delete(_db.itemCategories).go();
    await _db.delete(_db.categories).go();
    await _db.delete(_db.items).go();
  }

  Future<void> _insertCategories(List<ItemDetailEntity> items) async {
    final categoryMap = <String, ItemCategoryInfo>{};
    for (final item in items) {
      for (final cat in item.categories) {
        categoryMap[cat.id] = cat;
      }
    }

    await _db.batch((batch) {
      batch.insertAll(
        _db.categories,
        categoryMap.values
            .map((c) => CategoriesCompanion.insert(
                  id: c.id,
                  name: c.name,
                  normalizedName: c.normalizedName,
                ))
            .toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> _insertItemChunk(List<ItemDetailEntity> chunk) async {
    await _db.batch((b) {
      _batchInsertItems(b, chunk);
      _batchInsertItemCategories(b, chunk);
      _batchInsertHandbookCategories(b, chunk);
      _batchInsertPrices(b, chunk);
      _batchInsertContainedItems(b, chunk);
    });
  }

  void _batchInsertItems(Batch b, List<ItemDetailEntity> chunk) {
    b.insertAll(
      _db.items,
      chunk.map(_mapper.toItemCompanion).toList(),
      mode: InsertMode.insertOrReplace,
    );
  }

  void _batchInsertItemCategories(Batch b, List<ItemDetailEntity> chunk) {
    for (final item in chunk) {
      for (final cat in item.categories) {
        b.insert(
          _db.itemCategories,
          ItemCategoriesCompanion.insert(
            itemId: item.id,
            categoryId: cat.id,
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    }
  }

  void _batchInsertHandbookCategories(
      Batch b, List<ItemDetailEntity> chunk) {
    for (final item in chunk) {
      for (final catId in item.handbookCategoryIds) {
        b.insert(
          _db.itemHandbookCategories,
          ItemHandbookCategoriesCompanion.insert(
            itemId: item.id,
            categoryId: catId,
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    }
  }

  void _batchInsertPrices(Batch b, List<ItemDetailEntity> chunk) {
    for (final item in chunk) {
      for (final price in item.sellFor) {
        b.insert(
            _db.itemPrices, _mapper.toPriceCompanion(item.id, 'sell', price));
      }
      for (final price in item.buyFor) {
        b.insert(
            _db.itemPrices, _mapper.toPriceCompanion(item.id, 'buy', price));
      }
    }
  }

  void _batchInsertContainedItems(Batch b, List<ItemDetailEntity> chunk) {
    for (final item in chunk) {
      for (final contained in item.containsItems) {
        b.insert(
          _db.itemContainedItems,
          ItemContainedItemsCompanion.insert(
            itemId: item.id,
            containedItemId: contained.itemId,
            count: Value(contained.count),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    }
  }

  Future<List<ItemCategoryInfo>> _fetchCategories(String itemId) async {
    final query = _db.select(_db.categories).join([
      innerJoin(
        _db.itemCategories,
        _db.itemCategories.categoryId.equalsExp(_db.categories.id),
      ),
    ])
      ..where(_db.itemCategories.itemId.equals(itemId));

    final rows = await query.get();
    return rows
        .map((row) => row.readTable(_db.categories))
        .map((c) => ItemCategoryInfo(
              id: c.id,
              name: c.name,
              normalizedName: c.normalizedName,
            ))
        .toList();
  }

  Future<List<String>> _fetchHandbookCategoryIds(String itemId) async {
    final query = _db.select(_db.itemHandbookCategories)
      ..where((t) => t.itemId.equals(itemId));
    final rows = await query.get();
    return rows.map((r) => r.categoryId).toList();
  }

  Future<Map<String, List<ItemPriceInfo>>> _fetchPrices(
      String itemId) async {
    final query = _db.select(_db.itemPrices)
      ..where((t) => t.itemId.equals(itemId));
    final rows = await query.get();

    return {
      'sell': rows
          .where((r) => r.priceDirection == 'sell')
          .map(_mapper.toPriceInfo)
          .toList(),
      'buy': rows
          .where((r) => r.priceDirection == 'buy')
          .map(_mapper.toPriceInfo)
          .toList(),
    };
  }

  Future<List<ContainedItem>> _fetchContainedItems(String itemId) async {
    final query = _db.select(_db.itemContainedItems)
      ..where((t) => t.itemId.equals(itemId));
    final rows = await query.get();
    return rows
        .map((r) => ContainedItem(itemId: r.containedItemId, count: r.count))
        .toList();
  }
}
