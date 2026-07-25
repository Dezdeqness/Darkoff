import 'package:freezed_annotation/freezed_annotation.dart';

part 'boss_detail_ui_model.freezed.dart';

enum SpawnChanceTier { high, medium, low }

@freezed
abstract class BossDetailUiModel with _$BossDetailUiModel {
  const factory BossDetailUiModel({
    required String id,
    required String displayName,
    String? posterUrl,
    String? healthLabel,
    @Default([]) List<BossBodyPartUiModel> bodyParts,
    @Default([]) List<BossSpawnUiModel> spawns,
  }) = _BossDetailUiModel;
}

@freezed
abstract class BossBodyPartUiModel with _$BossBodyPartUiModel {
  const factory BossBodyPartUiModel({
    required String label,
    required String value,
  }) = _BossBodyPartUiModel;
}

@freezed
abstract class BossSpawnUiModel with _$BossSpawnUiModel {
  const factory BossSpawnUiModel({
    required String mapName,
    required String chanceLabel,
    required SpawnChanceTier tier,
    String? locations,
    @Default([]) List<String> escorts,
  }) = _BossSpawnUiModel;
}
