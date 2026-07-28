import 'package:darkoff/domain/entities/map_entity.dart';
import 'package:darkoff/presentation/features/maps/model/map_ui_model.dart';

class MapUiMapper {
  MapUiModel fromEntity(MapEntity entity) {
    return MapUiModel(
      id: entity.id,
      name: entity.name,
      normalizedName: entity.normalizedName,
      description: entity.description,
      players: entity.players,
      raidDuration: entity.raidDuration,
      minPlayerLevel: entity.minPlayerLevel,
      maxPlayerLevel: entity.maxPlayerLevel,
      playersLabel: entity.players ?? '—',
      durationLabel: entity.raidDuration != null
          ? '${entity.raidDuration} min'
          : '—',
      enemies: entity.enemies,
      bosses: entity.bosses.map(_boss).toList(),
      lootItemIds: entity.lootItemIds,
    );
  }

  List<MapUiModel> fromEntities(List<MapEntity> entities) {
    return entities.map(fromEntity).toList();
  }

  MapBossUiModel _boss(BossSpawnEntity boss) => MapBossUiModel(
    id: boss.id,
    name: boss.bossName,
    spawnChanceLabel: boss.spawnChance != null
        ? '${(boss.spawnChance! * 100).round()}%'
        : null,
    portraitUrl: boss.imagePortraitLink,
  );
}
