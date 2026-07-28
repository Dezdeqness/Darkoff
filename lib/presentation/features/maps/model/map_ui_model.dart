import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_ui_model.freezed.dart';

@freezed
abstract class MapUiModel with _$MapUiModel {
  const factory MapUiModel({
    required String id,
    required String name,
    required String normalizedName,
    required String playersLabel,
    required String durationLabel,
    String? description,
    String? players,
    int? raidDuration,
    int? minPlayerLevel,
    int? maxPlayerLevel,
    @Default([]) List<String> enemies,
    @Default([]) List<MapBossUiModel> bosses,
    @Default([]) List<String> lootItemIds,
  }) = _MapUiModel;
}

@freezed
abstract class MapBossUiModel with _$MapBossUiModel {
  const factory MapBossUiModel({
    required String id,
    required String name,
    String? spawnChanceLabel,
    String? portraitUrl,
  }) = _MapBossUiModel;
}
