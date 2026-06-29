import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/domain/entities/flea_item_entity.dart';
import 'package:drift/drift.dart';

class FleaCacheDao {
  FleaCacheDao({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  Future<List<FleaItemEntity>> getAll({String? category}) async {
    final query = _db.select(_db.fleaCacheItems)
      ..orderBy([(t) => OrderingTerm.asc(t.name)]);
    if (category != null && category.isNotEmpty) {
      query.where((t) => t.categoryName.equals(category));
    }
    final rows = await query.get();
    return rows.map(_toEntity).toList();
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

  FleaItemEntity _toEntity(FleaCacheItem row) => FleaItemEntity(
        id: row.id,
        name: row.name,
        shortName: row.shortName,
        iconLink: row.iconLink,
        avgPrice: row.avgPrice,
        low24hPrice: row.low24hPrice,
        high24hPrice: row.high24hPrice,
        changeLast48h: row.changeLast48h,
        changeLast48hPercent: row.changeLast48hPercent,
        categoryName: row.categoryName,
      );

  FleaCacheItemsCompanion _toCompanion(FleaItemEntity e) =>
      FleaCacheItemsCompanion.insert(
        id: e.id,
        name: e.name,
        shortName: e.shortName,
        iconLink: Value(e.iconLink),
        avgPrice: Value(e.avgPrice),
        low24hPrice: Value(e.low24hPrice),
        high24hPrice: Value(e.high24hPrice),
        changeLast48h: Value(e.changeLast48h),
        changeLast48hPercent: Value(e.changeLast48hPercent),
        categoryName: Value(e.categoryName),
      );
}
