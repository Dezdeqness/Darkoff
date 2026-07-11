import 'package:darkoff/domain/entities/hideout_progress_entity.dart';

abstract class HideoutProgressRepository {
  Future<HideoutProgressEntity> getProgress();

  Future<void> setOwnedCount({
    required String stationId,
    required int level,
    required String itemId,
    required int count,
  });

  Future<void> setLevelBuilt({
    required String stationId,
    required int level,
    required bool built,
  });

  Future<void> setTracked({
    required String stationId,
    required bool tracked,
  });
}
