import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/domain/entities/boss_entity.dart';
import 'package:darkoff/presentation/features/boss_detail/model/boss_detail_ui_model.dart';

class BossDetailUiMapper {
  BossDetailUiModel fromEntity(BossEntity entity) {
    return BossDetailUiModel(
      id: entity.id,
      displayName: entity.name,
      posterUrl: entity.imagePosterLink ?? entity.imagePortraitLink,
      healthLabel: (entity.healthMax ?? 0) > 0
          ? tr.bossDetail.healthTotal(hp: entity.healthMax!)
          : null,
      bodyParts: [
        for (final part in entity.bodyParts)
          BossBodyPartUiModel(
            label: _partLabel(part.part),
            value: '${part.max}',
          ),
      ],
      spawns: [
        for (final spawn in entity.mapSpawns)
          BossSpawnUiModel(
            mapName: spawn.mapName,
            chanceLabel: tr.bossDetail.spawnChance(
              percent: (spawn.spawnChance * 100).toStringAsFixed(0),
            ),
            tier: _tier(spawn.spawnChance),
            locations: spawn.locationNames.isNotEmpty
                ? spawn.locationNames.join(' · ')
                : null,
            escorts: [
              for (final e in spawn.escorts)
                tr.bossDetail.escort(
                  name: e.bossName,
                  count: e.count,
                  chance: (e.chance * 100).toStringAsFixed(0),
                ),
            ],
          ),
      ],
    );
  }

  SpawnChanceTier _tier(double chance) {
    if (chance >= 0.7) return SpawnChanceTier.high;
    if (chance >= 0.3) return SpawnChanceTier.medium;
    return SpawnChanceTier.low;
  }

  String _partLabel(String part) => switch (part) {
    'Chest' => tr.bossDetail.bodyPart.chest,
    'Head' => tr.bossDetail.bodyPart.head,
    'Stomach' => tr.bossDetail.bodyPart.stomach,
    'LeftArm' => tr.bossDetail.bodyPart.leftArm,
    'RightArm' => tr.bossDetail.bodyPart.rightArm,
    'LeftLeg' => tr.bossDetail.bodyPart.leftLeg,
    'RightLeg' => tr.bossDetail.bodyPart.rightLeg,
    _ => part,
  };
}
