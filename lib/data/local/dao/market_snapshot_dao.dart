import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/domain/entities/market_item_entity.dart';
import 'package:drift/drift.dart';

class MarketSnapshotDao {
  MarketSnapshotDao({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  Future<List<MarketItemEntity>> getAll() async {
    final rows = await (_db.select(_db.marketSnapshotItems)
          ..orderBy([(t) => OrderingTerm.asc(t.position)]))
        .get();
    return rows.map(_toEntity).toList();
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
    await (_db.delete(_db.marketSnapshotItems)
          ..where((t) => t.id.isIn(ids)))
        .go();
  }

  MarketItemEntity _toEntity(MarketSnapshotItem row) => MarketItemEntity(
        id: row.id,
        name: row.name,
        shortName: row.shortName,
        avg24hPrice: row.avg24hPrice,
        lastLowPrice: row.lastLowPrice,
        changeLast48hPercent: row.changeLast48hPercent,
      );

  MarketSnapshotItemsCompanion _toCompanion(MarketItemEntity e, int position) =>
      MarketSnapshotItemsCompanion.insert(
        id: e.id,
        name: e.name,
        shortName: e.shortName,
        avg24hPrice: Value(e.avg24hPrice),
        lastLowPrice: Value(e.lastLowPrice),
        changeLast48hPercent: Value(e.changeLast48hPercent),
        position: Value(position),
      );
}
