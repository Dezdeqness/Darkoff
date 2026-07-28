import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_entity.freezed.dart';

@freezed
abstract class MapEntity with _$MapEntity {
  const factory MapEntity({
    required String id,
    required String name,
    required String normalizedName,
    String? description,
    String? players,
    int? raidDuration,
    @Default([]) List<String> enemies,
    int? minPlayerLevel,
    int? maxPlayerLevel,
    @Default([]) List<BossSpawnEntity> bosses,
    @Default([]) List<String> lootItemIds,
  }) = _MapEntity;
}

@freezed
abstract class BossSpawnEntity with _$BossSpawnEntity {
  const factory BossSpawnEntity({
    required String id,
    required String bossName,
    double? spawnChance,
    String? imagePortraitLink,
  }) = _BossSpawnEntity;
}
