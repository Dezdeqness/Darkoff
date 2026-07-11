import 'package:darkoff/domain/entities/hideout_progress_entity.dart';
import 'package:darkoff/domain/repositories/hideout_progress_repository.dart';
import 'package:darkoff/service_locator/hideout_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hideout_progress_notifier.g.dart';

@riverpod
class HideoutProgressNotifier extends _$HideoutProgressNotifier {
  late HideoutProgressRepository _repository;

  @override
  HideoutProgressEntity build() {
    _repository = getIt<HideoutProgressRepository>();
    _load();
    return const HideoutProgressEntity();
  }

  Future<void> _load() async {
    state = await _repository.getProgress();
  }

  Future<void> setOwnedCount({
    required String stationId,
    required int level,
    required String itemId,
    required int count,
    required int maxCount,
  }) async {
    final clamped = count.clamp(0, maxCount);
    final key = HideoutProgressEntity.itemKey(stationId, level, itemId);

    state = state.copyWith(
      ownedCounts: {...state.ownedCounts, key: clamped},
    );

    await _repository.setOwnedCount(
      stationId: stationId,
      level: level,
      itemId: itemId,
      count: clamped,
    );
    if (clamped > 0 && !state.trackedStations.contains(stationId)) {
      await setTracked(stationId: stationId, tracked: true);
    }
  }

  Future<void> setTracked({
    required String stationId,
    required bool tracked,
  }) async {
    final next = {...state.trackedStations};
    tracked ? next.add(stationId) : next.remove(stationId);
    state = state.copyWith(trackedStations: next);

    await _repository.setTracked(stationId: stationId, tracked: tracked);
  }

  Future<void> toggleTracked(String stationId) => setTracked(
        stationId: stationId,
        tracked: !state.trackedStations.contains(stationId),
      );

  Future<void> toggleBuilt({
    required String stationId,
    required int level,
  }) async {
    final key = HideoutProgressEntity.levelKey(stationId, level);
    final built = !state.builtLevels.contains(key);

    final next = {...state.builtLevels};
    built ? next.add(key) : next.remove(key);
    state = state.copyWith(builtLevels: next);

    await _repository.setLevelBuilt(
      stationId: stationId,
      level: level,
      built: built,
    );
  }
}
