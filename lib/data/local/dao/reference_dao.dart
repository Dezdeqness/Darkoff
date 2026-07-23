import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/data/models/trader_dump_api.dart';
import 'package:drift/drift.dart';

class ReferenceDao {
  ReferenceDao({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  Future<void> insertTraders(
    Map<String, TraderDumpApi> traders,
    Map<String, String> traderLoc,
  ) async {
    await _db.transaction(() async {
      await _db.delete(_db.traders).go();
      await _db.batch((b) {
        for (final t in traders.values) {
          b.insert(
            _db.traders,
            TradersCompanion.insert(
              id: t.id,
              name: traderLoc[t.name] ?? t.name ?? t.id,
              normalizedName: t.normalizedName ?? '',
              imageLink: Value(t.imageLink),
            ),
            mode: InsertMode.insertOrReplace,
          );
        }
      });
    });
  }

  Future<void> insertMaps(Map<String, String> idToName) async {
    await _db.transaction(() async {
      await _db.delete(_db.maps).go();
      if (idToName.isEmpty) return;
      await _db.batch((b) {
        for (final entry in idToName.entries) {
          b.insert(
            _db.maps,
            MapsCompanion.insert(id: entry.key, name: entry.value),
            mode: InsertMode.insertOrReplace,
          );
        }
      });
    });
  }
}
