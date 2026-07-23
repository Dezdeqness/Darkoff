import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/domain/entities/market_item_entity.dart';
import 'package:drift/drift.dart';

class MarketSnapshotDao {
  MarketSnapshotDao({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  Future<List<MarketItemEntity>> getAll() async {
    final query = _db.select(_db.marketSnapshotItems).join([
      leftOuterJoin(
        _db.items,
        _db.items.id.equalsExp(_db.marketSnapshotItems.id),
      ),
    ])..orderBy([OrderingTerm.asc(_db.marketSnapshotItems.position)]);
    final rows = await query.get();
    return rows.map((row) {
      final snap = row.readTable(_db.marketSnapshotItems);
      final item = row.readTableOrNull(_db.items);
      return MarketItemEntity(
        id: snap.id,
        name: item?.name ?? item?.shortName ?? snap.id,
        shortName: item?.shortName ?? item?.name ?? snap.id,
        avg24hPrice: snap.avg24hPrice,
        lastLowPrice: snap.lastLowPrice,
        changeLast48hPercent: snap.changeLast48hPercent,
      );
    }).toList();
  }

  Future<void> upsertAll(List<MarketItemEntity> items) async {
    await _db.batch((b) {
      for (var i = 0; i < items.length; i++) {
        b.insert(
          _db.marketSnapshotItems,
          _toCompanion(items[i], i),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }

  Future<void> deleteByIds(List<String> ids) async {
    if (ids.isEmpty) return;
    await (_db.delete(_db.marketSnapshotItems)..where((t) => t.id.isIn(ids))).go();
  }

  MarketSnapshotItemsCompanion _toCompanion(MarketItemEntity e, int position) =>
      MarketSnapshotItemsCompanion.insert(
        id: e.id,
        avg24hPrice: Value(e.avg24hPrice),
        lastLowPrice: Value(e.lastLowPrice),
        changeLast48hPercent: Value(e.changeLast48hPercent),
        position: Value(position),
      );
}
