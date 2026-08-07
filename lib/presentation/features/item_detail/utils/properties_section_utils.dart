import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';

class PropertiesSectionUtils {
  const PropertiesSectionUtils._();

  static String getTitle(ItemProperties properties) {
    return switch (properties) {
      AmmoProperties() => tr.properties.section.ammo,
      ArmorProperties() => tr.properties.section.armor,
      ArmorAttachmentProperties() => tr.properties.section.armorAttachment,
      HelmetProperties() => tr.properties.section.helmet,
      WeaponProperties() => tr.properties.section.weapon,
      PresetProperties() => tr.properties.section.preset,
      MedKitProperties() => tr.properties.section.medKit,
      MedicalItemProperties() => tr.properties.section.medicalItem,
      PainkillerProperties() => tr.properties.section.painkiller,
      SurgicalKitProperties() => tr.properties.section.surgicalKit,
      StimProperties() => tr.properties.section.stim,
      FoodDrinkProperties() => tr.properties.section.foodDrink,
      BackpackProperties() => tr.properties.section.backpack,
      ContainerProperties() => tr.properties.section.container,
      ChestRigProperties() => tr.properties.section.chestRig,
      GlassesProperties() => tr.properties.section.glasses,
      GrenadeProperties() => tr.properties.section.grenade,
      HeadphoneProperties() => tr.properties.section.headphones,
      KeyProperties() => tr.properties.section.key,
      ScopeProperties() => tr.properties.section.scope,
      MagazineProperties() => tr.properties.section.magazine,
      BarrelProperties() => tr.properties.section.barrel,
      WeaponModProperties() => tr.properties.section.weaponMod,
      NightVisionProperties() => tr.properties.section.nightVision,
      MeleeProperties() => tr.properties.section.melee,
      ResourceProperties() => tr.properties.section.resource,
      HeadwearProperties() => tr.properties.section.headwear,
      UnknownProperties() => tr.properties.section.unknown,
    };
  }

  static List<(String, Object?)> getEntries(ItemProperties properties) {
    return switch (properties) {
      AmmoProperties p => [
          (tr.properties.label.caliber, p.caliber),
          (tr.properties.label.damage, p.damage),
          (tr.properties.label.armorDamage, p.armorDamage),
          (tr.properties.label.penetration, p.penetrationPower),
          (tr.properties.label.fragmentation, _formatPercent(p.fragmentationChance)),
          (tr.properties.label.projectiles, p.projectileCount),
          (tr.properties.label.ammoType, p.ammoType),
        ],
      ArmorProperties p => [
          (tr.properties.label.armorClass, p.armorClass),
          (tr.properties.label.durability, p.durability),
          (tr.properties.label.material, p.materialName),
          (tr.properties.label.type, p.armorType),
          (tr.properties.label.speedPenalty, _formatPercent(p.speedPenalty)),
          (tr.properties.label.turnPenalty, _formatPercent(p.turnPenalty)),
          (tr.properties.label.ergoPenalty, _formatNum(p.ergoPenalty)),
          (tr.properties.label.zones, _formatList(p.zones)),
        ],
      ArmorAttachmentProperties p => [
          (tr.properties.label.armorClass, p.armorClass),
          (tr.properties.label.durability, p.durability),
          (tr.properties.label.material, p.materialName),
          (tr.properties.label.speedPenalty, _formatPercent(p.speedPenalty)),
          (tr.properties.label.turnPenalty, _formatPercent(p.turnPenalty)),
          (tr.properties.label.ergoPenalty, _formatNum(p.ergoPenalty)),
          (tr.properties.label.zones, _formatList(p.zones)),
        ],
      HelmetProperties p => [
          (tr.properties.label.armorClass, p.armorClass),
          (tr.properties.label.durability, p.durability),
          (tr.properties.label.material, p.materialName),
          (tr.properties.label.headZones, _formatList(p.headZones)),
          (tr.properties.label.deafening, p.deafening),
          (tr.properties.label.blocksHeadset, p.blocksHeadset),
          (tr.properties.label.blindnessProtection, _formatPercent(p.blindnessProtection)),
          (tr.properties.label.speedPenalty, _formatPercent(p.speedPenalty)),
          (tr.properties.label.turnPenalty, _formatPercent(p.turnPenalty)),
          (tr.properties.label.ergoPenalty, _formatNum(p.ergoPenalty)),
        ],
      WeaponProperties p => [
          (tr.properties.label.caliber, p.caliber),
          (tr.properties.label.fireRate, _formatSuffix(p.fireRate, 'RPM')),
          (tr.properties.label.fireModes, _formatList(p.fireModes)),
          (tr.properties.label.ergonomics, _formatNum(p.ergonomics)),
          (tr.properties.label.verticalRecoil, p.recoilVertical),
          (tr.properties.label.horizontalRecoil, p.recoilHorizontal),
          (tr.properties.label.effectiveDistance, _formatSuffix(p.effectiveDistance, 'm')),
          (tr.properties.label.sightingRange, _formatSuffix(p.sightingRange, 'm')),
        ],
      PresetProperties p => [
          (tr.properties.label.baseWeapon, p.baseItemName),
          (tr.properties.label.ergonomics, _formatNum(p.ergonomics)),
          (tr.properties.label.verticalRecoil, p.recoilVertical),
          (tr.properties.label.horizontalRecoil, p.recoilHorizontal),
        ],
      MedKitProperties p => [
          (tr.properties.label.hp, p.hitpoints),
          (tr.properties.label.useTime, _formatSuffix(p.useTime, 's')),
          (tr.properties.label.maxHealPerUse, p.maxHealPerUse),
          (tr.properties.label.cures, _formatList(p.cures)),
        ],
      MedicalItemProperties p => [
          (tr.properties.label.uses, p.uses),
          (tr.properties.label.useTime, _formatSuffix(p.useTime, 's')),
          (tr.properties.label.cures, _formatList(p.cures)),
        ],
      PainkillerProperties p => [
          (tr.properties.label.uses, p.uses),
          (tr.properties.label.useTime, _formatSuffix(p.useTime, 's')),
          (tr.properties.label.duration, _formatDuration(p.painkillerDuration)),
          (tr.properties.label.cures, _formatList(p.cures)),
        ],
      SurgicalKitProperties p => [
          (tr.properties.label.uses, p.uses),
          (tr.properties.label.useTime, _formatSuffix(p.useTime, 's')),
          (tr.properties.label.minLimbHealth, _formatPercent(p.minLimbHealth)),
          (tr.properties.label.maxLimbHealth, _formatPercent(p.maxLimbHealth)),
          (tr.properties.label.cures, _formatList(p.cures)),
        ],
      StimProperties p => [
          (tr.properties.label.useTime, _formatSuffix(p.useTime, 's')),
          (tr.properties.label.cures, _formatList(p.cures)),
        ],
      FoodDrinkProperties p => [
          (tr.properties.label.energy, p.energy),
          (tr.properties.label.hydration, p.hydration),
          (tr.properties.label.units, p.units),
        ],
      BackpackProperties p => [
          (tr.properties.label.capacity, p.capacity),
          (tr.properties.label.speedPenalty, _formatPercent(p.speedPenalty)),
          (tr.properties.label.turnPenalty, _formatPercent(p.turnPenalty)),
          (tr.properties.label.ergoPenalty, _formatNum(p.ergoPenalty)),
        ],
      ContainerProperties p => [
          (tr.properties.label.capacity, p.capacity),
        ],
      ChestRigProperties p => [
          (tr.properties.label.armorClass, p.armorClass),
          (tr.properties.label.durability, p.durability),
          (tr.properties.label.capacity, p.capacity),
          (tr.properties.label.speedPenalty, _formatPercent(p.speedPenalty)),
          (tr.properties.label.turnPenalty, _formatPercent(p.turnPenalty)),
          (tr.properties.label.ergoPenalty, _formatNum(p.ergoPenalty)),
        ],
      GlassesProperties p => [
          (tr.properties.label.armorClass, p.armorClass),
          (tr.properties.label.durability, p.durability),
          (tr.properties.label.blindnessProtection, _formatPercent(p.blindnessProtection)),
        ],
      GrenadeProperties p => [
          (tr.properties.label.type, p.type),
          (tr.properties.label.fuse, _formatSuffix(p.fuse, 's')),
          (tr.properties.label.maxDistance, _formatSuffix(p.maxExplosionDistance, 'm')),
          (tr.properties.label.fragments, p.fragments),
        ],
      HeadphoneProperties p => [
          (tr.properties.label.ambientVolume, p.ambientVolume),
          (tr.properties.label.distortion, _formatNum(p.distortion)),
          (tr.properties.label.distanceModifier, _formatNum(p.distanceModifier)),
        ],
      KeyProperties p => [
          (tr.properties.label.uses, p.uses),
        ],
      ScopeProperties p => [
          (tr.properties.label.ergonomics, _formatNum(p.ergonomics)),
          (tr.properties.label.recoilModifier, _formatPercent(p.recoilModifier)),
          (tr.properties.label.zoomLevels, _formatZoomLevels(p.zoomLevels)),
        ],
      MagazineProperties p => [
          (tr.properties.label.capacity, p.capacity),
          (tr.properties.label.ergonomics, _formatNum(p.ergonomics)),
          (tr.properties.label.loadModifier, _formatPercent(p.loadModifier)),
          (tr.properties.label.checkModifier, _formatPercent(p.ammoCheckModifier)),
          (tr.properties.label.malfunction, _formatPercent(p.malfunctionChance)),
        ],
      BarrelProperties p => [
          (tr.properties.label.ergonomics, _formatNum(p.ergonomics)),
          (tr.properties.label.recoilModifier, _formatPercent(p.recoilModifier)),
        ],
      WeaponModProperties p => [
          (tr.properties.label.ergonomics, _formatNum(p.ergonomics)),
          (tr.properties.label.recoilModifier, _formatPercent(p.recoilModifier)),
          (tr.properties.label.accuracyModifier, _formatPercent(p.accuracyModifier)),
        ],
      NightVisionProperties p => [
          (tr.properties.label.intensity, _formatNum(p.intensity)),
          (tr.properties.label.noiseIntensity, _formatNum(p.noiseIntensity)),
          (tr.properties.label.noiseScale, _formatNum(p.noiseScale)),
          (tr.properties.label.diffuseIntensity, _formatNum(p.diffuseIntensity)),
        ],
      MeleeProperties p => [
          (tr.properties.label.slashDamage, p.slashDamage),
          (tr.properties.label.stabDamage, p.stabDamage),
          (tr.properties.label.hitRadius, _formatNum(p.hitRadius)),
        ],
      ResourceProperties p => [
          (tr.properties.label.units, p.units),
        ],
      HeadwearProperties() => <(String, Object?)>[],
      UnknownProperties() => <(String, Object?)>[],
    };
  }

  static List<(String, String)> getFilteredEntries(ItemProperties properties) {
    return getEntries(properties)
        .where((e) => e.$2 != null && e.$2.toString().isNotEmpty)
        .map((e) => (e.$1, e.$2.toString()))
        .toList();
  }

  // -- Formatting helpers --

  static String? _formatPercent(double? value) {
    if (value == null) return null;
    return '${(value * 100).toStringAsFixed(1)}%';
  }

  static String? _formatNum(double? value) {
    if (value == null) return null;
    if (value == value.truncateToDouble()) return value.toInt().toString();
    return value.toStringAsFixed(2);
  }

  static String? _formatSuffix(num? value, String suffix) {
    if (value == null) return null;
    return '$value$suffix';
  }

  static String? _formatDuration(double? seconds) {
    if (seconds == null) return null;
    return '${seconds.toInt()}s';
  }

  static String? _formatList(List<String> items) {
    if (items.isEmpty) return null;
    return items.join(', ');
  }

  static String? _formatZoomLevels(List<List<double>> levels) {
    if (levels.isEmpty) return null;
    return levels.map((l) => l.join('-')).join(', ');
  }
}
