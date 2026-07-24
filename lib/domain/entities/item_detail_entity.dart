import 'package:darkoff/domain/entities/item_category_info.dart';
import 'package:darkoff/domain/entities/item_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_detail_entity.freezed.dart';

@freezed
abstract class ItemDetailEntity with _$ItemDetailEntity {
  const factory ItemDetailEntity({
    required String id,
    required String? name,
    required String? shortName,
    required String? normalizedName,
    required String? description,
    required int basePrice,
    required int? avg24hPrice,
    required int? low24hPrice,
    required int? high24hPrice,
    required double? changeLast48h,
    required double? changeLast48hPercent,
    required int? lastLowPrice,
    required int? lastOfferCount,
    required int? width,
    required int? height,
    required double? weight,
    required String backgroundColor,
    required String? iconLink,
    required String? baseImageLink,
    required String? image512pxLink,
    required String? image8xLink,
    required String? wikiLink,
    required String? bsgCategoryId,
    required String? updated,
    @Default([]) List<ItemType> types,
    @Default([]) List<ItemCategoryInfo> categories,
    @Default([]) List<String> handbookCategoryIds,
    @Default([]) List<ItemPriceInfo> sellFor,
    @Default([]) List<ItemPriceInfo> buyFor,
    @Default([]) List<ContainedItem> containsItems,
    ItemProperties? properties,
  }) = _ItemDetailEntity;
}

@freezed
abstract class ContainedItem with _$ContainedItem {
  const factory ContainedItem({
    required String itemId,
    required int count,
  }) = _ContainedItem;
}

@freezed
abstract class ItemPriceInfo with _$ItemPriceInfo {
  const factory ItemPriceInfo({
    required int price,
    required String currency,
    required int? priceRUB,
    required String vendorName,
    required String? vendorNormalizedName,
    required String? vendorTypename,
    String? traderId,
    int? minTraderLevel,
    String? taskUnlockId,
    String? taskUnlockName,
    String? taskUnlockNormalizedName,
    @Default([]) List<PriceRequirement> requirements,
  }) = _ItemPriceInfo;
}

@freezed
abstract class PriceRequirement with _$PriceRequirement {
  const factory PriceRequirement({
    required String type,
    required int value,
  }) = _PriceRequirement;
}

@freezed
abstract class StimEffect with _$StimEffect {
  const factory StimEffect({
    required String type,
    required double chance,
    required int delay,
    required int duration,
    required double value,
    required bool percent,
    String? skillName,
  }) = _StimEffect;
}

// ─── Properties ───────────────────────────────────────────────

sealed class ItemProperties {
  const ItemProperties();
}

class AmmoProperties extends ItemProperties {
  final String? caliber;
  final int? damage;
  final int? armorDamage;
  final int? penetrationPower;
  final int? projectileCount;
  final double? fragmentationChance;
  final String? ammoType;
  final bool? tracer;

  const AmmoProperties({
    this.caliber,
    this.damage,
    this.armorDamage,
    this.penetrationPower,
    this.projectileCount,
    this.fragmentationChance,
    this.ammoType,
    this.tracer,
  });
}

class ArmorProperties extends ItemProperties {
  final int? armorClass;
  final String? materialId;
  final String? materialName;
  final List<String> zones;
  final int? durability;
  final double? ergoPenalty;
  final double? speedPenalty;
  final double? turnPenalty;
  final String? armorType;
  final String? armorSlotsJson;

  const ArmorProperties({
    this.armorClass,
    this.materialId,
    this.materialName,
    this.zones = const [],
    this.durability,
    this.ergoPenalty,
    this.speedPenalty,
    this.turnPenalty,
    this.armorType,
    this.armorSlotsJson,
  });
}

class ArmorAttachmentProperties extends ItemProperties {
  final int? armorClass;
  final String? materialId;
  final String? materialName;
  final List<String> zones;
  final int? durability;
  final double? ergoPenalty;
  final double? speedPenalty;
  final double? turnPenalty;

  const ArmorAttachmentProperties({
    this.armorClass,
    this.materialId,
    this.materialName,
    this.zones = const [],
    this.durability,
    this.ergoPenalty,
    this.speedPenalty,
    this.turnPenalty,
  });
}

class HelmetProperties extends ItemProperties {
  final int? armorClass;
  final String? materialId;
  final String? materialName;
  final List<String> headZones;
  final int? durability;
  final double? ergoPenalty;
  final double? speedPenalty;
  final double? turnPenalty;
  final String? deafening;
  final bool? blocksHeadset;
  final double? blindnessProtection;
  final double? ricochetY;
  final String? slotsJson;
  final String? armorSlotsJson;

  const HelmetProperties({
    this.armorClass,
    this.materialId,
    this.materialName,
    this.headZones = const [],
    this.durability,
    this.ergoPenalty,
    this.speedPenalty,
    this.turnPenalty,
    this.deafening,
    this.blocksHeadset,
    this.blindnessProtection,
    this.ricochetY,
    this.slotsJson,
    this.armorSlotsJson,
  });
}

class WeaponProperties extends ItemProperties {
  final String? caliber;
  final int? effectiveDistance;
  final double? ergonomics;
  final List<String> fireModes;
  final int? fireRate;
  final int? recoilVertical;
  final int? recoilHorizontal;
  final int? sightingRange;
  final double? recoilAngle;
  final double? recoilDispersion;
  final double? convergence;
  final double? cameraRecoil;
  final String? slotsJson;
  final String? defaultPresetId;
  final List<String> presetIds;

  const WeaponProperties({
    this.caliber,
    this.effectiveDistance,
    this.ergonomics,
    this.fireModes = const [],
    this.fireRate,
    this.recoilVertical,
    this.recoilHorizontal,
    this.sightingRange,
    this.recoilAngle,
    this.recoilDispersion,
    this.convergence,
    this.cameraRecoil,
    this.slotsJson,
    this.defaultPresetId,
    this.presetIds = const [],
  });
}

class PresetProperties extends ItemProperties {
  final String? baseItemId;
  final String? baseItemName;
  final String? baseItemNormalizedName;
  final double? ergonomics;
  final int? recoilVertical;
  final int? recoilHorizontal;

  const PresetProperties({
    this.baseItemId,
    this.baseItemName,
    this.baseItemNormalizedName,
    this.ergonomics,
    this.recoilVertical,
    this.recoilHorizontal,
  });
}

class MedKitProperties extends ItemProperties {
  final int? hitpoints;
  final int? useTime;
  final int? maxHealPerUse;
  final List<String> cures;
  final int? hpCostLightBleeding;
  final int? hpCostHeavyBleeding;

  const MedKitProperties({
    this.hitpoints,
    this.useTime,
    this.maxHealPerUse,
    this.cures = const [],
    this.hpCostLightBleeding,
    this.hpCostHeavyBleeding,
  });
}

class MedicalItemProperties extends ItemProperties {
  final int? uses;
  final int? useTime;
  final List<String> cures;

  const MedicalItemProperties({
    this.uses,
    this.useTime,
    this.cures = const [],
  });
}

class PainkillerProperties extends ItemProperties {
  final int? uses;
  final int? useTime;
  final List<String> cures;
  final double? painkillerDuration;
  final int? energyImpact;
  final int? hydrationImpact;

  const PainkillerProperties({
    this.uses,
    this.useTime,
    this.cures = const [],
    this.painkillerDuration,
    this.energyImpact,
    this.hydrationImpact,
  });
}

class SurgicalKitProperties extends ItemProperties {
  final int? uses;
  final int? useTime;
  final List<String> cures;
  final double? minLimbHealth;
  final double? maxLimbHealth;

  const SurgicalKitProperties({
    this.uses,
    this.useTime,
    this.cures = const [],
    this.minLimbHealth,
    this.maxLimbHealth,
  });
}

class StimProperties extends ItemProperties {
  final int? useTime;
  final List<String> cures;
  final List<StimEffect> stimEffects;

  const StimProperties({
    this.useTime,
    this.cures = const [],
    this.stimEffects = const [],
  });
}

class FoodDrinkProperties extends ItemProperties {
  final int? energy;
  final int? hydration;
  final int? units;
  final List<StimEffect> stimEffects;

  const FoodDrinkProperties({
    this.energy,
    this.hydration,
    this.units,
    this.stimEffects = const [],
  });
}

class BackpackProperties extends ItemProperties {
  final int? capacity;
  final double? speedPenalty;
  final double? turnPenalty;
  final double? ergoPenalty;
  final String? gridsJson;

  const BackpackProperties({
    this.capacity,
    this.speedPenalty,
    this.turnPenalty,
    this.ergoPenalty,
    this.gridsJson,
  });
}

class ContainerProperties extends ItemProperties {
  final int? capacity;
  final String? gridsJson;

  const ContainerProperties({this.capacity, this.gridsJson});
}

class ChestRigProperties extends ItemProperties {
  final int? armorClass;
  final String? materialId;
  final String? materialName;
  final List<String> zones;
  final int? durability;
  final int? capacity;
  final double? ergoPenalty;
  final double? speedPenalty;
  final double? turnPenalty;
  final String? gridsJson;
  final String? armorSlotsJson;

  const ChestRigProperties({
    this.armorClass,
    this.materialId,
    this.materialName,
    this.zones = const [],
    this.durability,
    this.capacity,
    this.ergoPenalty,
    this.speedPenalty,
    this.turnPenalty,
    this.gridsJson,
    this.armorSlotsJson,
  });
}

class GlassesProperties extends ItemProperties {
  final int? armorClass;
  final int? durability;
  final double? blindnessProtection;
  final double? ergoPenalty;
  final String? materialId;
  final String? materialName;

  const GlassesProperties({
    this.armorClass,
    this.durability,
    this.blindnessProtection,
    this.ergoPenalty,
    this.materialId,
    this.materialName,
  });
}

class GrenadeProperties extends ItemProperties {
  final String? type;
  final double? fuse;
  final int? maxExplosionDistance;
  final int? fragments;

  const GrenadeProperties({
    this.type,
    this.fuse,
    this.maxExplosionDistance,
    this.fragments,
  });
}

class HeadphoneProperties extends ItemProperties {
  final int? ambientVolume;
  final double? distortion;
  final double? distanceModifier;

  const HeadphoneProperties({
    this.ambientVolume,
    this.distortion,
    this.distanceModifier,
  });
}

class KeyProperties extends ItemProperties {
  final int? uses;

  const KeyProperties({this.uses});
}

class ScopeProperties extends ItemProperties {
  final double? ergonomics;
  final double? recoilModifier;
  final List<List<double>> zoomLevels;

  const ScopeProperties({
    this.ergonomics,
    this.recoilModifier,
    this.zoomLevels = const [],
  });
}

class MagazineProperties extends ItemProperties {
  final double? ergonomics;
  final int? capacity;
  final double? loadModifier;
  final double? ammoCheckModifier;
  final double? malfunctionChance;
  final double? recoilModifier;

  const MagazineProperties({
    this.ergonomics,
    this.capacity,
    this.loadModifier,
    this.ammoCheckModifier,
    this.malfunctionChance,
    this.recoilModifier,
  });
}

class BarrelProperties extends ItemProperties {
  final double? ergonomics;
  final double? recoilModifier;
  final String? slotsJson;

  const BarrelProperties({
    this.ergonomics,
    this.recoilModifier,
    this.slotsJson,
  });
}

class WeaponModProperties extends ItemProperties {
  final double? ergonomics;
  final double? recoilModifier;
  final double? accuracyModifier;
  final String? slotsJson;

  const WeaponModProperties({
    this.ergonomics,
    this.recoilModifier,
    this.accuracyModifier,
    this.slotsJson,
  });
}

class NightVisionProperties extends ItemProperties {
  final double? intensity;
  final double? noiseIntensity;
  final double? noiseScale;
  final double? diffuseIntensity;

  const NightVisionProperties({
    this.intensity,
    this.noiseIntensity,
    this.noiseScale,
    this.diffuseIntensity,
  });
}

class MeleeProperties extends ItemProperties {
  final int? slashDamage;
  final int? stabDamage;
  final double? hitRadius;

  const MeleeProperties({
    this.slashDamage,
    this.stabDamage,
    this.hitRadius,
  });
}

class ResourceProperties extends ItemProperties {
  final int? units;

  const ResourceProperties({this.units});
}

class HeadwearProperties extends ItemProperties {
  final String? slotsJson;

  const HeadwearProperties({this.slotsJson});
}

class UnknownProperties extends ItemProperties {
  const UnknownProperties();
}
