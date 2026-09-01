import 'package:darkoff/data/local/database.dart';
import 'package:hideout_progress_contract/hideout_progress_contract.dart';
import 'package:drift/drift.dart';

class HideoutProgressDao {
  HideoutProgressDao({required AppDatabase db}) : _db = db;

  final AppDatabase _db;

  Future<HideoutProgressEntity> getProgress() async {
    final owned = await _db.select(_db.hideoutOwnedItems).get();
    final built = await _db.select(_db.hideoutBuiltLevels).get();
    final tracked = await _db.select(_db.hideoutTrackedStations).get();

    return HideoutProgressEntity(
      ownedCounts: {
        for (final row in owned)
          HideoutProgressEntity.itemKey(row.stationId, row.level, row.itemId):
              row.ownedCount,
      },
      builtLevels: {
        for (final row in built)
          HideoutProgressEntity.levelKey(row.stationId, row.level),
      },
      trackedStations: {for (final row in tracked) row.stationId},
    );
  }

  Future<void> setTracked({
    required String stationId,
    required bool tracked,
  }) async {
    if (tracked) {
      await _db.into(_db.hideoutTrackedStations).insertOnConflictUpdate(HideoutTrackedStationsCompanion.insert(stationId: stationId));
    } else {
      await (_db.delete(_db.hideoutTrackedStations)
            ..where((t) => t.stationId.equals(stationId)))
          .go();
    }
  }

  Future<void> setOwnedCount({
    required String stationId,
    required int level,
    required String itemId,
    required int count,
  }) async {
    if (count <= 0) {
      await (_db.delete(_db.hideoutOwnedItems)
            ..where((t) =>
                t.stationId.equals(stationId) &
                t.level.equals(level) &
                t.itemId.equals(itemId)))
          .go();
      return;
    }

    await _db.into(_db.hideoutOwnedItems).insertOnConflictUpdate(
          HideoutOwnedItemsCompanion.insert(
            stationId: stationId,
            level: level,
            itemId: itemId,
            ownedCount: Value(count),
          ),
        );
  }

  Future<void> setLevelBuilt({
    required String stationId,
    required int level,
    required bool built,
  }) async {
    if (built) {
      await _db.into(_db.hideoutBuiltLevels).insertOnConflictUpdate(
            HideoutBuiltLevelsCompanion.insert(
              stationId: stationId,
              level: level,
            ),
          );
    } else {
      await (_db.delete(_db.hideoutBuiltLevels)
            ..where(
                (t) => t.stationId.equals(stationId) & t.level.equals(level)))
          .go();
    }
  }
}
