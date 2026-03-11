import 'package:darkoff/domain/entities/item_detail_entity.dart';

class WeaponPropertiesHelper {
  static Map<String, dynamic>? toJson(ItemProperties props) {
    return switch (props) {
      AmmoProperties p => {
          'type': 'ammo',
          'caliber': p.caliber,
          'damage': p.damage,
          'armorDamage': p.armorDamage,
          'penetrationPower': p.penetrationPower,
          'projectileCount': p.projectileCount,
          'fragmentationChance': p.fragmentationChance,
          'ammoType': p.ammoType,
        },
      WeaponProperties p => {
          'type': 'weapon',
          'caliber': p.caliber,
          'effectiveDistance': p.effectiveDistance,
          'ergonomics': p.ergonomics,
          'fireModes': p.fireModes,
          'fireRate': p.fireRate,
          'recoilVertical': p.recoilVertical,
          'recoilHorizontal': p.recoilHorizontal,
          'sightingRange': p.sightingRange,
          'recoilAngle': p.recoilAngle,
          'recoilDispersion': p.recoilDispersion,
          'convergence': p.convergence,
          'cameraRecoil': p.cameraRecoil,
          'slotsJson': p.slotsJson,
          'defaultPresetId': p.defaultPresetId,
          'presetIds': p.presetIds,
        },
      PresetProperties p => {
          'type': 'preset',
          'baseItemId': p.baseItemId,
          'baseItemName': p.baseItemName,
          'baseItemNormalizedName': p.baseItemNormalizedName,
          'ergonomics': p.ergonomics,
          'recoilVertical': p.recoilVertical,
          'recoilHorizontal': p.recoilHorizontal,
        },
      ScopeProperties p => {
          'type': 'scope',
          'ergonomics': p.ergonomics,
          'recoilModifier': p.recoilModifier,
          'zoomLevels': p.zoomLevels.map((l) => l.toList()).toList(),
        },
      MagazineProperties p => {
          'type': 'magazine',
          'ergonomics': p.ergonomics,
          'capacity': p.capacity,
          'loadModifier': p.loadModifier,
          'ammoCheckModifier': p.ammoCheckModifier,
          'malfunctionChance': p.malfunctionChance,
          'recoilModifier': p.recoilModifier,
        },
      BarrelProperties p => {
          'type': 'barrel',
          'ergonomics': p.ergonomics,
          'recoilModifier': p.recoilModifier,
          'slotsJson': p.slotsJson,
        },
      WeaponModProperties p => {
          'type': 'weaponMod',
          'ergonomics': p.ergonomics,
          'recoilModifier': p.recoilModifier,
          'accuracyModifier': p.accuracyModifier,
          'slotsJson': p.slotsJson,
        },
      GrenadeProperties p => {
          'type': 'grenade',
          'grenadeType': p.type,
          'fuse': p.fuse,
          'maxExplosionDistance': p.maxExplosionDistance,
          'fragments': p.fragments,
        },
      MeleeProperties p => {
          'type': 'melee',
          'slashDamage': p.slashDamage,
          'stabDamage': p.stabDamage,
          'hitRadius': p.hitRadius,
        },
      _ => null,
    };
  }

  static ItemProperties? fromJson(String type, Map<String, dynamic> json) {
    return switch (type) {
      'ammo' => AmmoProperties(
          caliber: json['caliber'] as String?,
          damage: json['damage'] as int?,
          armorDamage: json['armorDamage'] as int?,
          penetrationPower: json['penetrationPower'] as int?,
          projectileCount: json['projectileCount'] as int?,
          fragmentationChance:
              (json['fragmentationChance'] as num?)?.toDouble(),
          ammoType: json['ammoType'] as String?,
        ),
      'weapon' => WeaponProperties(
          caliber: json['caliber'] as String?,
          effectiveDistance: json['effectiveDistance'] as int?,
          ergonomics: (json['ergonomics'] as num?)?.toDouble(),
          fireModes: _stringList(json['fireModes']),
          fireRate: json['fireRate'] as int?,
          recoilVertical: json['recoilVertical'] as int?,
          recoilHorizontal: json['recoilHorizontal'] as int?,
          sightingRange: json['sightingRange'] as int?,
          recoilAngle: (json['recoilAngle'] as num?)?.toDouble(),
          recoilDispersion: (json['recoilDispersion'] as num?)?.toDouble(),
          convergence: (json['convergence'] as num?)?.toDouble(),
          cameraRecoil: (json['cameraRecoil'] as num?)?.toDouble(),
          slotsJson: json['slotsJson'] as String?,
          defaultPresetId: json['defaultPresetId'] as String?,
          presetIds: _stringList(json['presetIds']),
        ),
      'preset' => PresetProperties(
          baseItemId: json['baseItemId'] as String?,
          baseItemName: json['baseItemName'] as String?,
          baseItemNormalizedName: json['baseItemNormalizedName'] as String?,
          ergonomics: (json['ergonomics'] as num?)?.toDouble(),
          recoilVertical: json['recoilVertical'] as int?,
          recoilHorizontal: json['recoilHorizontal'] as int?,
        ),
      'scope' => ScopeProperties(
          ergonomics: (json['ergonomics'] as num?)?.toDouble(),
          recoilModifier: (json['recoilModifier'] as num?)?.toDouble(),
          zoomLevels: (json['zoomLevels'] as List<dynamic>?)
                  ?.map((l) => (l as List<dynamic>)
                      .map((v) => (v as num).toDouble())
                      .toList())
                  .toList() ??
              [],
        ),
      'magazine' => MagazineProperties(
          ergonomics: (json['ergonomics'] as num?)?.toDouble(),
          capacity: json['capacity'] as int?,
          loadModifier: (json['loadModifier'] as num?)?.toDouble(),
          ammoCheckModifier: (json['ammoCheckModifier'] as num?)?.toDouble(),
          malfunctionChance: (json['malfunctionChance'] as num?)?.toDouble(),
          recoilModifier: (json['recoilModifier'] as num?)?.toDouble(),
        ),
      'barrel' => BarrelProperties(
          ergonomics: (json['ergonomics'] as num?)?.toDouble(),
          recoilModifier: (json['recoilModifier'] as num?)?.toDouble(),
          slotsJson: json['slotsJson'] as String?,
        ),
      'weaponMod' => WeaponModProperties(
          ergonomics: (json['ergonomics'] as num?)?.toDouble(),
          recoilModifier: (json['recoilModifier'] as num?)?.toDouble(),
          accuracyModifier: (json['accuracyModifier'] as num?)?.toDouble(),
          slotsJson: json['slotsJson'] as String?,
        ),
      'grenade' => GrenadeProperties(
          type: json['grenadeType'] as String?,
          fuse: (json['fuse'] as num?)?.toDouble(),
          maxExplosionDistance: json['maxExplosionDistance'] as int?,
          fragments: json['fragments'] as int?,
        ),
      'melee' => MeleeProperties(
          slashDamage: json['slashDamage'] as int?,
          stabDamage: json['stabDamage'] as int?,
          hitRadius: (json['hitRadius'] as num?)?.toDouble(),
        ),
      _ => null,
    };
  }

  static List<String> _stringList(dynamic value) {
    if (value == null) return [];
    return (value as List<dynamic>).whereType<String>().toList();
  }
}
