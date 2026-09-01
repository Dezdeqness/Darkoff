import 'package:darkoff/data/local/database.dart';
import 'package:flea_contract/flea_contract.dart';
import 'package:drift/drift.dart';

class FleaCacheDao {
  FleaCacheDao({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  Future<List<FleaItemEntity>> getAll() async {
    final query = _db.select(_db.fleaCacheItems).join([
      leftOuterJoin(
        _db.items,
        _db.items.id.equalsExp(_db.fleaCacheItems.id),
      ),
    ])..orderBy([OrderingTerm.asc(_db.items.name)]);

    final rows = await query.get();
    return rows.map((row) {
      final cache = row.readTable(_db.fleaCacheItems);
      final item = row.readTableOrNull(_db.items);
      return FleaItemEntity(
        id: cache.id,
        name: item?.name ?? item?.shortName ?? cache.id,
        shortName: item?.shortName ?? item?.name ?? cache.id,
        iconLink: item?.iconLink,
        avgPrice: cache.avgPrice,
        low24hPrice: cache.low24hPrice,
        high24hPrice: cache.high24hPrice,
        changeLast48h: cache.changeLast48h,
        changeLast48hPercent: cache.changeLast48hPercent,
        categoryName: cache.categoryName,
      );
    }).toList();
  }

  Future<void> upsertAll(List<FleaItemEntity> items) async {
    await _db.batch((b) {
      b.insertAll(
        _db.fleaCacheItems,
        items.map(_toCompanion).toList(),
        mode: InsertMode.insertOrReplace,
      );
    });
  }

  Future<void> deleteByIds(List<String> ids) async {
    if (ids.isEmpty) return;
    await (_db.delete(_db.fleaCacheItems)..where((t) => t.id.isIn(ids))).go();
  }

  FleaCacheItemsCompanion _toCompanion(FleaItemEntity e) =>
      FleaCacheItemsCompanion.insert(
        id: e.id,
        avgPrice: Value(e.avgPrice),
        low24hPrice: Value(e.low24hPrice),
        high24hPrice: Value(e.high24hPrice),
        changeLast48h: Value(e.changeLast48h),
        changeLast48hPercent: Value(e.changeLast48hPercent),
        categoryName: Value(e.categoryName),
      );
}
