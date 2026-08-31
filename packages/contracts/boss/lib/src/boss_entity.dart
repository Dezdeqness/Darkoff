import 'package:freezed_annotation/freezed_annotation.dart';

part 'boss_entity.freezed.dart';

@freezed
abstract class BossEntity with _$BossEntity {
  const factory BossEntity({
    required String id,
    required String name,
    required String normalizedName,
    String? imagePortraitLink,
    String? imagePosterLink,
    int? healthMin,
    int? healthMax,
    @Default([]) List<BossBodyPartHealthEntity> bodyParts,
    @Default([]) List<BossMapSpawnEntity> mapSpawns,
    @Default([]) List<BossLootEntity> loot,
  }) = _BossEntity;
}

@freezed
abstract class BossLootEntity with _$BossLootEntity {
  const factory BossLootEntity({
    required String itemId,
    @Default(0) double prevalence,
  }) = _BossLootEntity;
}

@freezed
abstract class BossBodyPartHealthEntity with _$BossBodyPartHealthEntity {
  const factory BossBodyPartHealthEntity({
    required String part,
    required int max,
  }) = _BossBodyPartHealthEntity;
}

@freezed
abstract class BossMapSpawnEntity with _$BossMapSpawnEntity {
  const factory BossMapSpawnEntity({
    required String mapName,
    required double spawnChance,
    @Default([]) List<String> locationNames,
    @Default([]) List<BossEscortEntity> escorts,
  }) = _BossMapSpawnEntity;
}

@freezed
abstract class BossEscortEntity with _$BossEscortEntity {
  const factory BossEscortEntity({
    required String bossName,
    required int count,
    required double chance,
  }) = _BossEscortEntity;
}
