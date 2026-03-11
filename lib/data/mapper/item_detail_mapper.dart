import 'dart:convert';

import 'package:darkoff/data/service/qraphql/queries/item_detail.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/items.graphql.dart';
import 'package:darkoff/data/utils/item_type_mapper.dart';
import 'package:darkoff/domain/entities/item_category_info.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';

class ItemDetailMapper {
  ItemDetailEntity fromGraphql(Query$DarkoffItems$items item) {
    return ItemDetailEntity(
      id: item.id,
      name: item.name,
      shortName: item.shortName,
      normalizedName: item.normalizedName,
      description: null,
      basePrice: item.basePrice,
      avg24hPrice: item.avg24hPrice,
      low24hPrice: item.low24hPrice,
      high24hPrice: item.high24hPrice,
      changeLast48h: item.changeLast48h,
      changeLast48hPercent: item.changeLast48hPercent,
      lastLowPrice: item.lastLowPrice,
      lastOfferCount: item.lastOfferCount,
      width: item.width,
      height: item.height,
      weight: item.weight,
      backgroundColor: item.backgroundColor,
      iconLink: item.iconLink,
      baseImageLink: item.baseImageLink,
      image512pxLink: item.image512pxLink,
      image8xLink: item.image8xLink,
      wikiLink: item.wikiLink,
      bsgCategoryId: item.bsgCategoryId,
      updated: item.updated,
      types: item.types
          .whereType()
          .map((t) => ItemTypeUtils.fromGraphqlEnum(t))
          .toList(),
      categories: item.categories
          .whereType<Query$DarkoffItems$items$categories>()
          .map(
            (c) => ItemCategoryInfo(
              id: c.id,
              name: c.name,
              normalizedName: c.normalizedName,
            ),
          )
          .toList(),
      handbookCategoryIds: item.handbookCategories
              ?.whereType<Query$DarkoffItems$items$handbookCategories>()
              .map((h) => h.id)
              .toList() ??
          [],
      sellFor: _mapPrices(item.sellFor),
      buyFor: _mapPrices(item.buyFor),
      containsItems: item.containsItems
              ?.whereType<Query$DarkoffItems$items$containsItems>()
              .map((c) => ContainedItem(
                    itemId: c.item.id,
                    count: c.count.toInt(),
                  ))
              .toList() ??
          [],
      properties: _mapProperties(item.properties),
    );
  }

  List<ItemPriceInfo> _mapPrices(List<Fragment$ItemPriceFragment?>? prices) {
    if (prices == null) return [];
    return prices
        .whereType<Fragment$ItemPriceFragment>()
        .where((p) => p.price != null && p.currency != null)
        .map((p) {
      final vendor = p.vendor;
      String? traderId;
      int? minTraderLevel;
      String? taskUnlockId;
      String? taskUnlockName;
      String? taskUnlockNormalizedName;
      List<PriceRequirement> requirements = [];

      if (vendor is Fragment$ItemPriceFragment$vendor$$TraderOffer) {
        traderId = vendor.trader.id;
        minTraderLevel = vendor.minTraderLevel;
        taskUnlockId = vendor.taskUnlock?.id;
        taskUnlockName = vendor.taskUnlock?.name;
        taskUnlockNormalizedName = vendor.taskUnlock?.normalizedName;
      }

      if (p.requirements.isNotEmpty) {
        requirements = p.requirements
            .whereType<Fragment$ItemPriceFragment$requirements>()
            .where((r) => r.value != null)
            .map((r) => PriceRequirement(
                  type: r.type.toString(),
                  value: r.value!,
                ))
            .toList();
      }

      return ItemPriceInfo(
        price: p.price!,
        currency: p.currency!,
        priceRUB: p.priceRUB,
        vendorName: vendor.name,
        vendorNormalizedName: vendor.normalizedName,
        vendorTypename: vendor.$__typename,
        traderId: traderId,
        minTraderLevel: minTraderLevel,
        taskUnlockId: taskUnlockId,
        taskUnlockName: taskUnlockName,
        taskUnlockNormalizedName: taskUnlockNormalizedName,
        requirements: requirements,
      );
    }).toList();
  }

  ItemProperties? _mapProperties(
      Query$DarkoffItems$items$properties? props) {
    if (props == null) return null;

    return switch (props) {
      Query$DarkoffItems$items$properties$$ItemPropertiesAmmo p =>
        AmmoProperties(
          caliber: p.caliber,
          damage: p.damage,
          armorDamage: p.armorDamage,
          penetrationPower: p.penetrationPower,
          fragmentationChance: p.fragmentationChance,
          projectileCount: p.projectileCount,
          ammoType: p.ammoType,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesArmor p =>
        ArmorProperties(
          armorClass: p.$class,
          materialId: p.material?.id,
          materialName: p.material?.name,
          zones: p.zones?.whereType<String>().toList() ?? [],
          durability: p.durability,
          ergoPenalty: p.ergoPenalty,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
          armorSlotsJson: _encodeJson(p.armorSlots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesArmorAttachment p =>
        ArmorAttachmentProperties(
          armorClass: p.$class,
          materialId: p.material?.id,
          materialName: p.material?.name,
          zones: p.zones?.whereType<String>().toList() ?? [],
          durability: p.durability,
          ergoPenalty: p.ergoPenalty,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesHelmet p =>
        HelmetProperties(
          armorClass: p.$class,
          materialId: p.material?.id,
          materialName: p.material?.name,
          headZones: p.headZones?.whereType<String>().toList() ?? [],
          durability: p.durability,
          ergoPenalty: p.ergoPenalty,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
          deafening: p.deafening,
          blocksHeadset: p.blocksHeadset,
          blindnessProtection: p.blindnessProtection,
          ricochetY: p.ricochetY,
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesWeapon p =>
        WeaponProperties(
          caliber: p.caliber,
          effectiveDistance: p.effectiveDistance,
          ergonomics: p.ergonomics,
          fireModes: p.fireModes?.whereType<String>().toList() ?? [],
          fireRate: p.fireRate,
          recoilVertical: p.recoilVertical,
          recoilHorizontal: p.recoilHorizontal,
          sightingRange: p.sightingRange,
          recoilAngle: p.recoilAngle?.toDouble(),
          recoilDispersion: p.recoilDispersion?.toDouble(),
          convergence: p.convergence,
          cameraRecoil: p.cameraRecoil,
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
          defaultPresetId: p.defaultPreset?.id,
          presetIds: p.presets?.whereType<Query$DarkoffItems$items$properties$$ItemPropertiesWeapon$presets>().map((pr) => pr.id).toList() ?? [],
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesPreset p =>
        PresetProperties(
          baseItemId: p.baseItem.id,
          baseItemName: p.baseItem.shortName ?? p.baseItem.name,
          baseItemNormalizedName: p.baseItem.normalizedName,
          ergonomics: p.ergonomics,
          recoilVertical: p.recoilVertical,
          recoilHorizontal: p.recoilHorizontal,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesMedKit p =>
        MedKitProperties(
          hitpoints: p.hitpoints,
          useTime: p.useTime,
          maxHealPerUse: p.maxHealPerUse,
          cures: p.cures?.whereType<String>().toList() ?? [],
          hpCostLightBleeding: p.hpCostLightBleeding,
          hpCostHeavyBleeding: p.hpCostHeavyBleeding,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesMedicalItem p =>
        MedicalItemProperties(
          uses: p.uses,
          useTime: p.useTime,
          cures: p.cures?.whereType<String>().toList() ?? [],
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesPainkiller p =>
        PainkillerProperties(
          uses: p.uses,
          useTime: p.useTime,
          painkillerDuration: p.painkillerDuration?.toDouble(),
          cures: p.cures?.whereType<String>().toList() ?? [],
          energyImpact: p.energyImpact,
          hydrationImpact: p.hydrationImpact,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesSurgicalKit p =>
        SurgicalKitProperties(
          uses: p.uses,
          useTime: p.useTime,
          cures: p.cures?.whereType<String>().toList() ?? [],
          minLimbHealth: p.minLimbHealth,
          maxLimbHealth: p.maxLimbHealth,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesStim p =>
        StimProperties(
          useTime: p.useTime,
          cures: p.cures?.whereType<String>().toList() ?? [],
          stimEffects: p.stimEffects
                  ?.whereType<Fragment$StimEffectFragment>()
                  .map(_mapStimEffect)
                  .toList() ??
              [],
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesFoodDrink p =>
        FoodDrinkProperties(
          energy: p.energy,
          hydration: p.hydration,
          units: p.units,
          stimEffects: p.stimEffects
                  ?.whereType<Fragment$StimEffectFragment>()
                  .map(_mapStimEffect)
                  .toList() ??
              [],
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesBackpack p =>
        BackpackProperties(
          capacity: p.capacity,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
          ergoPenalty: p.ergoPenalty,
          gridsJson: _encodeJson(p.grids?.map((g) => g?.toJson()).toList()),
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesContainer p =>
        ContainerProperties(
          capacity: p.capacity,
          gridsJson: _encodeJson(p.grids?.map((g) => g?.toJson()).toList()),
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesChestRig p =>
        ChestRigProperties(
          armorClass: p.$class,
          materialId: p.material?.id,
          materialName: p.material?.name,
          zones: p.zones?.whereType<String>().toList() ?? [],
          durability: p.durability,
          capacity: p.capacity,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
          ergoPenalty: p.ergoPenalty,
          gridsJson: _encodeJson(p.grids?.map((g) => g?.toJson()).toList()),
          armorSlotsJson: _encodeJson(p.armorSlots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesGlasses p =>
        GlassesProperties(
          armorClass: p.$class,
          durability: p.durability,
          blindnessProtection: p.blindnessProtection,
          ergoPenalty: p.ergoPenalty,
          materialId: p.material?.id,
          materialName: p.material?.name,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesGrenade p =>
        GrenadeProperties(
          type: p.type,
          fuse: p.fuse,
          maxExplosionDistance: p.maxExplosionDistance,
          fragments: p.fragments,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesHeadphone p =>
        HeadphoneProperties(
          ambientVolume: p.ambientVolume,
          distortion: p.distortion,
          distanceModifier: p.distanceModifier,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesKey p =>
        KeyProperties(uses: p.uses),
      Query$DarkoffItems$items$properties$$ItemPropertiesScope p =>
        ScopeProperties(
          ergonomics: p.ergonomics,
          recoilModifier: p.recoilModifier,
          zoomLevels: p.zoomLevels
                  ?.whereType<List<dynamic>>()
                  .map((l) => l.whereType<num>().map((v) => v.toDouble()).toList())
                  .toList() ??
              [],
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesMagazine p =>
        MagazineProperties(
          ergonomics: p.ergonomics,
          capacity: p.capacity,
          loadModifier: p.loadModifier,
          ammoCheckModifier: p.ammoCheckModifier,
          malfunctionChance: p.malfunctionChance,
          recoilModifier: p.recoilModifier,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesBarrel p =>
        BarrelProperties(
          ergonomics: p.ergonomics,
          recoilModifier: p.recoilModifier,
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesWeaponMod p =>
        WeaponModProperties(
          ergonomics: p.ergonomics,
          recoilModifier: p.recoilModifier,
          accuracyModifier: p.accuracyModifier,
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesNightVision p =>
        NightVisionProperties(
          intensity: p.intensity,
          noiseIntensity: p.noiseIntensity,
          noiseScale: p.noiseScale,
          diffuseIntensity: p.diffuseIntensity,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesMelee p =>
        MeleeProperties(
          slashDamage: p.slashDamage,
          stabDamage: p.stabDamage,
          hitRadius: p.hitRadius,
        ),
      Query$DarkoffItems$items$properties$$ItemPropertiesResource p =>
        ResourceProperties(units: p.units),
      Query$DarkoffItems$items$properties$$ItemPropertiesHeadwear p =>
        HeadwearProperties(
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
        ),
      _ => const UnknownProperties(),
    };
  }

  ItemDetailEntity fromDetailQuery(Query$DarkoffItemDetail$item item) {
    return ItemDetailEntity(
      id: item.id,
      name: item.name,
      shortName: item.shortName,
      normalizedName: item.normalizedName,
      description: item.description,
      basePrice: item.basePrice,
      avg24hPrice: item.avg24hPrice,
      low24hPrice: item.low24hPrice,
      high24hPrice: item.high24hPrice,
      changeLast48h: item.changeLast48h,
      changeLast48hPercent: item.changeLast48hPercent,
      lastLowPrice: item.lastLowPrice,
      lastOfferCount: item.lastOfferCount,
      width: item.width,
      height: item.height,
      weight: item.weight,
      backgroundColor: item.backgroundColor,
      iconLink: item.iconLink,
      baseImageLink: item.baseImageLink,
      image512pxLink: item.image512pxLink,
      image8xLink: item.image8xLink,
      wikiLink: item.wikiLink,
      bsgCategoryId: item.bsgCategoryId,
      updated: item.updated,
      types: item.types
          .whereType()
          .map((t) => ItemTypeUtils.fromGraphqlEnum(t))
          .toList(),
      categories: item.categories
          .whereType<Query$DarkoffItemDetail$item$categories>()
          .map(
            (c) => ItemCategoryInfo(
              id: c.id,
              name: c.name,
              normalizedName: c.normalizedName,
            ),
          )
          .toList(),
      handbookCategoryIds: item.handbookCategories
              .whereType<Query$DarkoffItemDetail$item$handbookCategories>()
              .map((h) => h.id)
              .toList(),
      sellFor: _mapPrices(item.sellFor),
      buyFor: _mapPrices(item.buyFor),
      containsItems: item.containsItems
              ?.whereType<Query$DarkoffItemDetail$item$containsItems>()
              .map((c) => ContainedItem(
                    itemId: c.item.id,
                    count: c.count.toInt(),
                  ))
              .toList() ??
          [],
      properties: _mapDetailProperties(item.properties),
    );
  }

  ItemProperties? _mapDetailProperties(
      Query$DarkoffItemDetail$item$properties? props) {
    if (props == null) return null;

    return switch (props) {
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesAmmo p =>
        AmmoProperties(
          caliber: p.caliber,
          damage: p.damage,
          armorDamage: p.armorDamage,
          penetrationPower: p.penetrationPower,
          fragmentationChance: p.fragmentationChance,
          projectileCount: p.projectileCount,
          ammoType: p.ammoType,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesArmor p =>
        ArmorProperties(
          armorClass: p.$class,
          materialId: p.material?.id,
          materialName: p.material?.name,
          zones: p.zones?.whereType<String>().toList() ?? [],
          durability: p.durability,
          ergoPenalty: p.ergoPenalty,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
          armorSlotsJson: _encodeJson(p.armorSlots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesArmorAttachment p =>
        ArmorAttachmentProperties(
          armorClass: p.$class,
          materialId: p.material?.id,
          materialName: p.material?.name,
          zones: p.zones?.whereType<String>().toList() ?? [],
          durability: p.durability,
          ergoPenalty: p.ergoPenalty,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesHelmet p =>
        HelmetProperties(
          armorClass: p.$class,
          materialId: p.material?.id,
          materialName: p.material?.name,
          headZones: p.headZones?.whereType<String>().toList() ?? [],
          durability: p.durability,
          ergoPenalty: p.ergoPenalty,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
          deafening: p.deafening,
          blocksHeadset: p.blocksHeadset,
          blindnessProtection: p.blindnessProtection,
          ricochetY: p.ricochetY,
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesWeapon p =>
        WeaponProperties(
          caliber: p.caliber,
          effectiveDistance: p.effectiveDistance,
          ergonomics: p.ergonomics,
          fireModes: p.fireModes?.whereType<String>().toList() ?? [],
          fireRate: p.fireRate,
          recoilVertical: p.recoilVertical,
          recoilHorizontal: p.recoilHorizontal,
          sightingRange: p.sightingRange,
          recoilAngle: p.recoilAngle?.toDouble(),
          recoilDispersion: p.recoilDispersion?.toDouble(),
          convergence: p.convergence,
          cameraRecoil: p.cameraRecoil,
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
          defaultPresetId: p.defaultPreset?.id,
          presetIds: p.presets?.whereType<Query$DarkoffItemDetail$item$properties$$ItemPropertiesWeapon$presets>().map((pr) => pr.id).toList() ?? [],
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesPreset p =>
        PresetProperties(
          baseItemId: p.baseItem.id,
          baseItemName: p.baseItem.shortName ?? p.baseItem.name,
          baseItemNormalizedName: p.baseItem.normalizedName,
          ergonomics: p.ergonomics,
          recoilVertical: p.recoilVertical,
          recoilHorizontal: p.recoilHorizontal,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesMedKit p =>
        MedKitProperties(
          hitpoints: p.hitpoints,
          useTime: p.useTime,
          maxHealPerUse: p.maxHealPerUse,
          cures: p.cures?.whereType<String>().toList() ?? [],
          hpCostLightBleeding: p.hpCostLightBleeding,
          hpCostHeavyBleeding: p.hpCostHeavyBleeding,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesMedicalItem p =>
        MedicalItemProperties(
          uses: p.uses,
          useTime: p.useTime,
          cures: p.cures?.whereType<String>().toList() ?? [],
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesPainkiller p =>
        PainkillerProperties(
          uses: p.uses,
          useTime: p.useTime,
          painkillerDuration: p.painkillerDuration?.toDouble(),
          cures: p.cures?.whereType<String>().toList() ?? [],
          energyImpact: p.energyImpact,
          hydrationImpact: p.hydrationImpact,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesSurgicalKit p =>
        SurgicalKitProperties(
          uses: p.uses,
          useTime: p.useTime,
          cures: p.cures?.whereType<String>().toList() ?? [],
          minLimbHealth: p.minLimbHealth,
          maxLimbHealth: p.maxLimbHealth,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesStim p =>
        StimProperties(
          useTime: p.useTime,
          cures: p.cures?.whereType<String>().toList() ?? [],
          stimEffects: p.stimEffects
                  ?.whereType<Fragment$StimEffectFragment>()
                  .map(_mapStimEffect)
                  .toList() ??
              [],
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesFoodDrink p =>
        FoodDrinkProperties(
          energy: p.energy,
          hydration: p.hydration,
          units: p.units,
          stimEffects: p.stimEffects
                  ?.whereType<Fragment$StimEffectFragment>()
                  .map(_mapStimEffect)
                  .toList() ??
              [],
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesBackpack p =>
        BackpackProperties(
          capacity: p.capacity,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
          ergoPenalty: p.ergoPenalty,
          gridsJson: _encodeJson(p.grids?.map((g) => g?.toJson()).toList()),
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesContainer p =>
        ContainerProperties(
          capacity: p.capacity,
          gridsJson: _encodeJson(p.grids?.map((g) => g?.toJson()).toList()),
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesChestRig p =>
        ChestRigProperties(
          armorClass: p.$class,
          materialId: p.material?.id,
          materialName: p.material?.name,
          zones: p.zones?.whereType<String>().toList() ?? [],
          durability: p.durability,
          capacity: p.capacity,
          speedPenalty: p.speedPenalty,
          turnPenalty: p.turnPenalty,
          ergoPenalty: p.ergoPenalty,
          gridsJson: _encodeJson(p.grids?.map((g) => g?.toJson()).toList()),
          armorSlotsJson: _encodeJson(p.armorSlots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesGlasses p =>
        GlassesProperties(
          armorClass: p.$class,
          durability: p.durability,
          blindnessProtection: p.blindnessProtection,
          ergoPenalty: p.ergoPenalty,
          materialId: p.material?.id,
          materialName: p.material?.name,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesGrenade p =>
        GrenadeProperties(
          type: p.type,
          fuse: p.fuse,
          maxExplosionDistance: p.maxExplosionDistance,
          fragments: p.fragments,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesHeadphone p =>
        HeadphoneProperties(
          ambientVolume: p.ambientVolume,
          distortion: p.distortion,
          distanceModifier: p.distanceModifier,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesKey p =>
        KeyProperties(uses: p.uses),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesScope p =>
        ScopeProperties(
          ergonomics: p.ergonomics,
          recoilModifier: p.recoilModifier,
          zoomLevels: p.zoomLevels
                  ?.whereType<List<dynamic>>()
                  .map((l) => l.whereType<num>().map((v) => v.toDouble()).toList())
                  .toList() ??
              [],
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesMagazine p =>
        MagazineProperties(
          ergonomics: p.ergonomics,
          capacity: p.capacity,
          loadModifier: p.loadModifier,
          ammoCheckModifier: p.ammoCheckModifier,
          malfunctionChance: p.malfunctionChance,
          recoilModifier: p.recoilModifier,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesBarrel p =>
        BarrelProperties(
          ergonomics: p.ergonomics,
          recoilModifier: p.recoilModifier,
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesWeaponMod p =>
        WeaponModProperties(
          ergonomics: p.ergonomics,
          recoilModifier: p.recoilModifier,
          accuracyModifier: p.accuracyModifier,
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesNightVision p =>
        NightVisionProperties(
          intensity: p.intensity,
          noiseIntensity: p.noiseIntensity,
          noiseScale: p.noiseScale,
          diffuseIntensity: p.diffuseIntensity,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesMelee p =>
        MeleeProperties(
          slashDamage: p.slashDamage,
          stabDamage: p.stabDamage,
          hitRadius: p.hitRadius,
        ),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesResource p =>
        ResourceProperties(units: p.units),
      Query$DarkoffItemDetail$item$properties$$ItemPropertiesHeadwear p =>
        HeadwearProperties(
          slotsJson: _encodeJson(p.slots?.map((s) => s?.toJson()).toList()),
        ),
      _ => const UnknownProperties(),
    };
  }

  StimEffect _mapStimEffect(Fragment$StimEffectFragment e) => StimEffect(
        type: e.type,
        chance: e.chance,
        delay: e.delay,
        duration: e.duration,
        value: e.value,
        percent: e.percent,
        skillName: e.skillName,
      );

  String? _encodeJson(dynamic value) {
    if (value == null) return null;
    return jsonEncode(value);
  }
}
