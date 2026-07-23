import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_api.freezed.dart';
part 'item_api.g.dart';

@JsonSerializable(createToJson: false)
class ItemApi {
  const ItemApi({
    required this.id,
    this.name,
    this.shortName,
    this.normalizedName,
    this.description,
    this.basePrice,
    this.avg24hPrice,
    this.low24hPrice,
    this.high24hPrice,
    this.changeLast48h,
    this.changeLast48hPercent,
    this.lastLowPrice,
    this.lastOfferCount,
    this.width,
    this.height,
    this.weight,
    this.backgroundColor,
    this.iconLink,
    this.baseImageLink,
    this.image512pxLink,
    this.image8xLink,
    this.wikiLink,
    this.updated,
    this.types,
    this.categories,
    this.handbookCategories,
    this.containsItems,
    this.sellToTrader,
    this.buyFromTrader,
    this.properties,
  });

  factory ItemApi.fromJson(Map<String, dynamic> json) =>
      _$ItemApiFromJson(json);

  final String id;
  final String? name;
  final String? shortName;
  final String? normalizedName;
  final String? description;
  final num? basePrice;
  final num? avg24hPrice;
  final num? low24hPrice;
  final num? high24hPrice;
  final num? changeLast48h;
  final num? changeLast48hPercent;
  final num? lastLowPrice;
  final num? lastOfferCount;
  final num? width;
  final num? height;
  final num? weight;
  final String? backgroundColor;
  final String? iconLink;
  final String? baseImageLink;
  final String? image512pxLink;
  final String? image8xLink;
  final String? wikiLink;
  final String? updated;
  final List<String>? types;
  final List<String>? categories;
  final List<String>? handbookCategories;
  final List<ContainedRefApi>? containsItems;
  final List<TraderOfferApi>? sellToTrader;
  final List<TraderOfferApi>? buyFromTrader;
  final Map<String, dynamic>? properties;
}

@JsonSerializable(createToJson: false)
class ContainedRefApi {
  const ContainedRefApi({required this.item, this.count});

  factory ContainedRefApi.fromJson(Map<String, dynamic> json) =>
      _$ContainedRefApiFromJson(json);

  final String item;
  final num? count;
}

@JsonSerializable(createToJson: false)
class TraderOfferApi {
  const TraderOfferApi({
    this.trader,
    this.price,
    this.priceRUB,
    this.currency,
    this.minTraderLevel,
    this.taskUnlock,
  });

  factory TraderOfferApi.fromJson(Map<String, dynamic> json) =>
      _$TraderOfferApiFromJson(json);

  final String? trader;
  final num? price;
  final num? priceRUB;
  final String? currency;
  final num? minTraderLevel;
  final String? taskUnlock;
}

@JsonSerializable()
class StimEffectApi {
  const StimEffectApi({
    this.type,
    this.chance,
    this.delay,
    this.duration,
    this.value,
    this.percent,
    this.skillName,
  });

  factory StimEffectApi.fromJson(Map<String, dynamic> json) =>
      _$StimEffectApiFromJson(json);

  final String? type;
  final num? chance;
  final num? delay;
  final num? duration;
  final num? value;
  final bool? percent;
  final String? skillName;
}

@Freezed(unionKey: 'propertiesType')
sealed class PropertiesApi with _$PropertiesApi {
  @FreezedUnionValue('ItemPropertiesAmmo')
  const factory PropertiesApi.ammo({
    String? caliber,
    int? damage,
    int? armorDamage,
    int? penetrationPower,
    int? projectileCount,
    num? fragmentationChance,
    String? ammoType,
    bool? tracer,
  }) = AmmoPropertiesApi;

  @FreezedUnionValue('ItemPropertiesArmor')
  const factory PropertiesApi.armor({
    @JsonKey(name: 'class') int? armorClass,
    String? material,
    @Default([]) List<String> zones,
    int? durability,
    num? ergoPenalty,
    num? speedPenalty,
    num? turnPenalty,
    String? armorType,
    Object? armorSlots,
  }) = ArmorPropertiesApi;

  @FreezedUnionValue('ItemPropertiesArmorAttachment')
  const factory PropertiesApi.armorAttachment({
    @JsonKey(name: 'class') int? armorClass,
    String? material,
    @Default([]) List<String> zones,
    int? durability,
    num? ergoPenalty,
    num? speedPenalty,
    num? turnPenalty,
  }) = ArmorAttachmentPropertiesApi;

  @FreezedUnionValue('ItemPropertiesHelmet')
  const factory PropertiesApi.helmet({
    @JsonKey(name: 'class') int? armorClass,
    String? material,
    @Default([]) List<String> headZones,
    int? durability,
    num? ergoPenalty,
    num? speedPenalty,
    num? turnPenalty,
    String? deafening,
    bool? blocksHeadset,
    num? blindnessProtection,
    num? ricochetY,
    Object? slots,
    Object? armorSlots,
  }) = HelmetPropertiesApi;

  @FreezedUnionValue('ItemPropertiesWeapon')
  const factory PropertiesApi.weapon({
    String? caliber,
    int? effectiveDistance,
    num? ergonomics,
    @Default([]) List<String> fireModes,
    int? fireRate,
    int? recoilVertical,
    int? recoilHorizontal,
    int? sightingRange,
    num? recoilAngle,
    num? recoilDispersion,
    num? convergence,
    num? cameraRecoil,
    Object? slots,
    String? defaultPreset,
    @Default([]) List<String> presets,
  }) = WeaponPropertiesApi;

  @FreezedUnionValue('ItemPropertiesPreset')
  const factory PropertiesApi.preset({
    String? baseItem,
    num? ergonomics,
    int? recoilVertical,
    int? recoilHorizontal,
  }) = PresetPropertiesApi;

  @FreezedUnionValue('ItemPropertiesMedKit')
  const factory PropertiesApi.medKit({
    int? hitpoints,
    int? useTime,
    int? maxHealPerUse,
    @Default([]) List<String> cures,
    int? hpCostLightBleeding,
    int? hpCostHeavyBleeding,
  }) = MedKitPropertiesApi;

  @FreezedUnionValue('ItemPropertiesMedicalItem')
  const factory PropertiesApi.medicalItem({
    int? uses,
    int? useTime,
    @Default([]) List<String> cures,
  }) = MedicalItemPropertiesApi;

  @FreezedUnionValue('ItemPropertiesPainkiller')
  const factory PropertiesApi.painkiller({
    int? uses,
    int? useTime,
    @Default([]) List<String> cures,
    num? painkillerDuration,
    int? energyImpact,
    int? hydrationImpact,
  }) = PainkillerPropertiesApi;

  @FreezedUnionValue('ItemPropertiesSurgicalKit')
  const factory PropertiesApi.surgicalKit({
    int? uses,
    int? useTime,
    @Default([]) List<String> cures,
    num? minLimbHealth,
    num? maxLimbHealth,
  }) = SurgicalKitPropertiesApi;

  @FreezedUnionValue('ItemPropertiesStim')
  const factory PropertiesApi.stim({
    int? useTime,
    @Default([]) List<String> cures,
    @Default([]) List<StimEffectApi> stimEffects,
  }) = StimPropertiesApi;

  @FreezedUnionValue('ItemPropertiesFoodDrink')
  const factory PropertiesApi.foodDrink({
    int? energy,
    int? hydration,
    int? units,
    @Default([]) List<StimEffectApi> stimEffects,
  }) = FoodDrinkPropertiesApi;

  @FreezedUnionValue('ItemPropertiesBackpack')
  const factory PropertiesApi.backpack({
    int? capacity,
    num? speedPenalty,
    num? turnPenalty,
    num? ergoPenalty,
    Object? grids,
  }) = BackpackPropertiesApi;

  @FreezedUnionValue('ItemPropertiesContainer')
  const factory PropertiesApi.container({
    int? capacity,
    Object? grids,
  }) = ContainerPropertiesApi;

  @FreezedUnionValue('ItemPropertiesChestRig')
  const factory PropertiesApi.chestRig({
    @JsonKey(name: 'class') int? armorClass,
    String? material,
    @Default([]) List<String> zones,
    int? durability,
    int? capacity,
    num? ergoPenalty,
    num? speedPenalty,
    num? turnPenalty,
    Object? grids,
    Object? armorSlots,
  }) = ChestRigPropertiesApi;

  @FreezedUnionValue('ItemPropertiesGlasses')
  const factory PropertiesApi.glasses({
    @JsonKey(name: 'class') int? armorClass,
    int? durability,
    num? blindnessProtection,
    num? ergoPenalty,
    String? material,
  }) = GlassesPropertiesApi;

  @FreezedUnionValue('ItemPropertiesGrenade')
  const factory PropertiesApi.grenade({
    String? type,
    num? fuse,
    int? maxExplosionDistance,
    int? fragments,
  }) = GrenadePropertiesApi;

  @FreezedUnionValue('ItemPropertiesHeadphone')
  const factory PropertiesApi.headphone({
    int? ambientVolume,
    num? distortion,
    num? distanceModifier,
  }) = HeadphonePropertiesApi;

  @FreezedUnionValue('ItemPropertiesKey')
  const factory PropertiesApi.key({int? uses}) = KeyPropertiesApi;

  @FreezedUnionValue('ItemPropertiesScope')
  const factory PropertiesApi.scope({
    num? ergonomics,
    num? recoilModifier,
    @Default([]) List<List<num>> zoomLevels,
  }) = ScopePropertiesApi;

  @FreezedUnionValue('ItemPropertiesMagazine')
  const factory PropertiesApi.magazine({
    num? ergonomics,
    int? capacity,
    num? loadModifier,
    num? ammoCheckModifier,
    num? malfunctionChance,
    num? recoilModifier,
  }) = MagazinePropertiesApi;

  @FreezedUnionValue('ItemPropertiesBarrel')
  const factory PropertiesApi.barrel({
    num? ergonomics,
    num? recoilModifier,
    Object? slots,
  }) = BarrelPropertiesApi;

  @FreezedUnionValue('ItemPropertiesWeaponMod')
  const factory PropertiesApi.weaponMod({
    num? ergonomics,
    num? recoilModifier,
    num? accuracyModifier,
    Object? slots,
  }) = WeaponModPropertiesApi;

  @FreezedUnionValue('ItemPropertiesNightVision')
  const factory PropertiesApi.nightVision({
    num? intensity,
    num? noiseIntensity,
    num? noiseScale,
    num? diffuseIntensity,
  }) = NightVisionPropertiesApi;

  @FreezedUnionValue('ItemPropertiesMelee')
  const factory PropertiesApi.melee({
    int? slashDamage,
    int? stabDamage,
    num? hitRadius,
  }) = MeleePropertiesApi;

  @FreezedUnionValue('ItemPropertiesResource')
  const factory PropertiesApi.resource({int? units}) = ResourcePropertiesApi;

  @FreezedUnionValue('ItemPropertiesHeadwear')
  const factory PropertiesApi.headwear({Object? slots}) = HeadwearPropertiesApi;

  factory PropertiesApi.fromJson(Map<String, dynamic> json) =>
      _$PropertiesApiFromJson(json);
}

const kKnownPropertiesTypes = <String>{
  'ItemPropertiesAmmo',
  'ItemPropertiesArmor',
  'ItemPropertiesArmorAttachment',
  'ItemPropertiesHelmet',
  'ItemPropertiesWeapon',
  'ItemPropertiesPreset',
  'ItemPropertiesMedKit',
  'ItemPropertiesMedicalItem',
  'ItemPropertiesPainkiller',
  'ItemPropertiesSurgicalKit',
  'ItemPropertiesStim',
  'ItemPropertiesFoodDrink',
  'ItemPropertiesBackpack',
  'ItemPropertiesContainer',
  'ItemPropertiesChestRig',
  'ItemPropertiesGlasses',
  'ItemPropertiesGrenade',
  'ItemPropertiesHeadphone',
  'ItemPropertiesKey',
  'ItemPropertiesScope',
  'ItemPropertiesMagazine',
  'ItemPropertiesBarrel',
  'ItemPropertiesWeaponMod',
  'ItemPropertiesNightVision',
  'ItemPropertiesMelee',
  'ItemPropertiesResource',
  'ItemPropertiesHeadwear',
};
