import 'package:freezed_annotation/freezed_annotation.dart';

part 'hideout_progress_entity.freezed.dart';

@freezed
abstract class HideoutProgressEntity with _$HideoutProgressEntity {
  const factory HideoutProgressEntity({
    @Default({}) Map<String, int> ownedCounts,
    @Default({}) Set<String> builtLevels,
    @Default({}) Set<String> trackedStations,
  }) = _HideoutProgressEntity;

  static String levelKey(String stationId, int level) => '$stationId|$level';

  static String itemKey(String stationId, int level, String itemId) =>
      '$stationId|$level|$itemId';
}
