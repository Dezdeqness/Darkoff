import 'package:darkoff/domain/entities/item_detail_entity.dart';

class PropertiesSectionUtils {
  const PropertiesSectionUtils._();

  static String getTitle(ItemProperties properties) {
    return switch (properties) {
      AmmoProperties() => 'Ammo Properties',
      ArmorProperties() => 'Armor Properties',
      ArmorAttachmentProperties() => 'Armor Attachment',
      HelmetProperties() => 'Helmet Properties',
      WeaponProperties() => 'Weapon Properties',
      PresetProperties() => 'Weapon Preset',
      MedKitProperties() => 'Medical Kit',
      MedicalItemProperties() => 'Medical Item',
      PainkillerProperties() => 'Painkiller',
      SurgicalKitProperties() => 'Surgical Kit',
      StimProperties() => 'Stimulant',
      FoodDrinkProperties() => 'Food & Drink',
      BackpackProperties() => 'Backpack',
      ContainerProperties() => 'Container',
      ChestRigProperties() => 'Chest Rig',
      GlassesProperties() => 'Glasses',
      GrenadeProperties() => 'Grenade',
      HeadphoneProperties() => 'Headphones',
      KeyProperties() => 'Key',
      ScopeProperties() => 'Scope',
      MagazineProperties() => 'Magazine',
      BarrelProperties() => 'Barrel',
      WeaponModProperties() => 'Weapon Mod',
      NightVisionProperties() => 'Night Vision',
      MeleeProperties() => 'Melee',
      ResourceProperties() => 'Resource',
      HeadwearProperties() => 'Headwear',
      UnknownProperties() => 'Properties',
    };
  }

  static List<(String, Object?)> getEntries(ItemProperties properties) {
    return switch (properties) {
      AmmoProperties p => [
          ('Caliber', p.caliber),
          ('Damage', p.damage),
          ('Armor Damage', p.armorDamage),
          ('Penetration', p.penetrationPower),
          ('Fragmentation', _formatPercent(p.fragmentationChance)),
          ('Projectiles', p.projectileCount),
          ('Ammo Type', p.ammoType),
        ],
      ArmorProperties p => [
          ('Class', p.armorClass),
          ('Durability', p.durability),
          ('Material', p.materialName),
          ('Type', p.armorType),
          ('Speed Penalty', _formatPercent(p.speedPenalty)),
          ('Turn Penalty', _formatPercent(p.turnPenalty)),
          ('Ergo Penalty', _formatNum(p.ergoPenalty)),
          ('Zones', _formatList(p.zones)),
        ],
      ArmorAttachmentProperties p => [
          ('Class', p.armorClass),
          ('Durability', p.durability),
          ('Material', p.materialName),
          ('Speed Penalty', _formatPercent(p.speedPenalty)),
          ('Turn Penalty', _formatPercent(p.turnPenalty)),
          ('Ergo Penalty', _formatNum(p.ergoPenalty)),
          ('Zones', _formatList(p.zones)),
        ],
      HelmetProperties p => [
          ('Class', p.armorClass),
          ('Durability', p.durability),
          ('Material', p.materialName),
          ('Head Zones', _formatList(p.headZones)),
          ('Deafening', p.deafening),
          ('Blocks Headset', p.blocksHeadset),
          ('Blindness Protection', _formatPercent(p.blindnessProtection)),
          ('Speed Penalty', _formatPercent(p.speedPenalty)),
          ('Turn Penalty', _formatPercent(p.turnPenalty)),
          ('Ergo Penalty', _formatNum(p.ergoPenalty)),
        ],
      WeaponProperties p => [
          ('Caliber', p.caliber),
          ('Fire Rate', _formatSuffix(p.fireRate, 'RPM')),
          ('Fire Modes', _formatList(p.fireModes)),
          ('Ergonomics', _formatNum(p.ergonomics)),
          ('Vertical Recoil', p.recoilVertical),
          ('Horizontal Recoil', p.recoilHorizontal),
          ('Effective Distance', _formatSuffix(p.effectiveDistance, 'm')),
          ('Sighting Range', _formatSuffix(p.sightingRange, 'm')),
        ],
      PresetProperties p => [
          ('Base Weapon', p.baseItemName),
          ('Ergonomics', _formatNum(p.ergonomics)),
          ('Vertical Recoil', p.recoilVertical),
          ('Horizontal Recoil', p.recoilHorizontal),
        ],
      MedKitProperties p => [
          ('HP', p.hitpoints),
          ('Use Time', _formatSuffix(p.useTime, 's')),
          ('Max Heal/Use', p.maxHealPerUse),
          ('Cures', _formatList(p.cures)),
        ],
      MedicalItemProperties p => [
          ('Uses', p.uses),
          ('Use Time', _formatSuffix(p.useTime, 's')),
          ('Cures', _formatList(p.cures)),
        ],
      PainkillerProperties p => [
          ('Uses', p.uses),
          ('Use Time', _formatSuffix(p.useTime, 's')),
          ('Duration', _formatDuration(p.painkillerDuration)),
          ('Cures', _formatList(p.cures)),
        ],
      SurgicalKitProperties p => [
          ('Uses', p.uses),
          ('Use Time', _formatSuffix(p.useTime, 's')),
          ('Min Limb Health', _formatPercent(p.minLimbHealth)),
          ('Max Limb Health', _formatPercent(p.maxLimbHealth)),
          ('Cures', _formatList(p.cures)),
        ],
      StimProperties p => [
          ('Use Time', _formatSuffix(p.useTime, 's')),
          ('Cures', _formatList(p.cures)),
        ],
      FoodDrinkProperties p => [
          ('Energy', p.energy),
          ('Hydration', p.hydration),
          ('Units', p.units),
        ],
      BackpackProperties p => [
          ('Capacity', p.capacity),
          ('Speed Penalty', _formatPercent(p.speedPenalty)),
          ('Turn Penalty', _formatPercent(p.turnPenalty)),
          ('Ergo Penalty', _formatNum(p.ergoPenalty)),
        ],
      ContainerProperties p => [
          ('Capacity', p.capacity),
        ],
      ChestRigProperties p => [
          ('Class', p.armorClass),
          ('Durability', p.durability),
          ('Capacity', p.capacity),
          ('Speed Penalty', _formatPercent(p.speedPenalty)),
          ('Turn Penalty', _formatPercent(p.turnPenalty)),
          ('Ergo Penalty', _formatNum(p.ergoPenalty)),
        ],
      GlassesProperties p => [
          ('Class', p.armorClass),
          ('Durability', p.durability),
          ('Blindness Protection', _formatPercent(p.blindnessProtection)),
        ],
      GrenadeProperties p => [
          ('Type', p.type),
          ('Fuse', _formatSuffix(p.fuse, 's')),
          ('Max Distance', _formatSuffix(p.maxExplosionDistance, 'm')),
          ('Fragments', p.fragments),
        ],
      HeadphoneProperties p => [
          ('Ambient Volume', p.ambientVolume),
          ('Distortion', _formatNum(p.distortion)),
          ('Distance Modifier', _formatNum(p.distanceModifier)),
        ],
      KeyProperties p => [
          ('Uses', p.uses),
        ],
      ScopeProperties p => [
          ('Ergonomics', _formatNum(p.ergonomics)),
          ('Recoil Modifier', _formatPercent(p.recoilModifier)),
          ('Zoom Levels', _formatZoomLevels(p.zoomLevels)),
        ],
      MagazineProperties p => [
          ('Capacity', p.capacity),
          ('Ergonomics', _formatNum(p.ergonomics)),
          ('Load Modifier', _formatPercent(p.loadModifier)),
          ('Check Modifier', _formatPercent(p.ammoCheckModifier)),
          ('Malfunction', _formatPercent(p.malfunctionChance)),
        ],
      BarrelProperties p => [
          ('Ergonomics', _formatNum(p.ergonomics)),
          ('Recoil Modifier', _formatPercent(p.recoilModifier)),
        ],
      WeaponModProperties p => [
          ('Ergonomics', _formatNum(p.ergonomics)),
          ('Recoil Modifier', _formatPercent(p.recoilModifier)),
          ('Accuracy Modifier', _formatPercent(p.accuracyModifier)),
        ],
      NightVisionProperties p => [
          ('Intensity', _formatNum(p.intensity)),
          ('Noise Intensity', _formatNum(p.noiseIntensity)),
          ('Noise Scale', _formatNum(p.noiseScale)),
          ('Diffuse Intensity', _formatNum(p.diffuseIntensity)),
        ],
      MeleeProperties p => [
          ('Slash Damage', p.slashDamage),
          ('Stab Damage', p.stabDamage),
          ('Hit Radius', _formatNum(p.hitRadius)),
        ],
      ResourceProperties p => [
          ('Units', p.units),
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
