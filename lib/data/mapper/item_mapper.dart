import 'dart:convert';

import 'package:darkoff/data/local/dao/helpers/properties_serializer.dart';
import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/data/models/items_response.dart'
    show ItemCategoryApi, ItemsData;
import 'package:darkoff/data/models/item_api.dart';
import 'package:darkoff/data/models/trader_dump_api.dart';
import 'package:ammo_contract/ammo_contract.dart';
import 'package:flea_contract/flea_contract.dart';
import 'package:darkoff/domain/entities/item_category_info.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:darkoff/domain/entities/item_type.dart';
import 'package:keys_contract/keys_contract.dart';
import 'package:market_contract/market_contract.dart';
import 'package:drift/drift.dart';

class ItemMapContext {
  const ItemMapContext({
    required this.itemLoc,
    required this.itemCategories,
    required this.traders,
    required this.traderLoc,
    required this.items,
  });

  final Map<String, String> itemLoc;
  final Map<String, ItemCategoryApi> itemCategories;
  final Map<String, TraderDumpApi> traders;
  final Map<String, String> traderLoc;
  final Map<String, ItemApi> items;
}

class ItemMapper {
  const ItemMapper();

  List<ItemDetailEntity> mapAll({
    required ItemsData data,
    required Map<String, TraderDumpApi> traders,
    required Map<String, String> itemLoc,
    required Map<String, String> traderLoc,
  }) {
    final ctx = ItemMapContext(
      itemLoc: itemLoc,
      itemCategories: data.itemCategories,
      traders: traders,
      traderLoc: traderLoc,
      items: data.items,
    );
    return [for (final dto in data.items.values) map(dto, ctx)];
  }

  String? _loc(Map<String, String> loc, String? key) =>
      key == null ? null : (loc[key] ?? key);

  ItemDetailEntity map(ItemApi dto, ItemMapContext ctx) {
    final categories = dto.categories ?? const [];
    return ItemDetailEntity(
      id: dto.id,
      name: _loc(ctx.itemLoc, dto.name),
      shortName: _loc(ctx.itemLoc, dto.shortName),
      normalizedName: dto.normalizedName,
      description: _loc(ctx.itemLoc, dto.description),
      basePrice: dto.basePrice?.toInt() ?? 0,
      avg24hPrice: dto.avg24hPrice?.toInt(),
      low24hPrice: dto.low24hPrice?.toInt(),
      high24hPrice: dto.high24hPrice?.toInt(),
      changeLast48h: dto.changeLast48h?.toDouble(),
      changeLast48hPercent: dto.changeLast48hPercent?.toDouble(),
      lastLowPrice: dto.lastLowPrice?.toInt(),
      lastOfferCount: dto.lastOfferCount?.toInt(),
      width: dto.width?.toInt(),
      height: dto.height?.toInt(),
      weight: dto.weight?.toDouble(),
      backgroundColor: dto.backgroundColor ?? '',
      iconLink: dto.iconLink,
      baseImageLink: dto.baseImageLink,
      image512pxLink: dto.image512pxLink,
      image8xLink: dto.image8xLink,
      wikiLink: dto.wikiLink,
      bsgCategoryId: categories.isNotEmpty ? categories.first : null,
      updated: dto.updated,
      types: [for (final t in (dto.types ?? const [])) _type(t)],
      categories: [for (final c in categories) _category(c, ctx)],
      handbookCategoryIds: dto.handbookCategories ?? const [],
      sellFor: _prices(dto.sellToTrader, dto, ctx),
      buyFor: _prices(dto.buyFromTrader, dto, ctx),
      containsItems: [
        for (final c in (dto.containsItems ?? const []))
          ContainedItem(itemId: c.item, count: c.count?.toInt() ?? 1),
      ],
      properties: _properties(dto.properties, ctx),
    );
  }

  ItemType _type(String raw) => ItemType.values.firstWhere(
    (t) => t.name == raw,
    orElse: () => ItemType.unknown,
  );

  ItemCategoryInfo _category(String id, ItemMapContext ctx) {
    final c = ctx.itemCategories[id];
    return ItemCategoryInfo(
      id: id,
      name: _loc(ctx.itemLoc, c?.name) ?? id,
      normalizedName: c?.normalizedName ?? '',
    );
  }

  List<ItemPriceInfo> _prices(
    List<TraderOfferApi>? offers,
    ItemApi item,
    ItemMapContext ctx,
  ) {
    final out = <ItemPriceInfo>[];
    for (final o in (offers ?? const [])) {
      final trader = ctx.traders[o.trader];
      out.add(
        ItemPriceInfo(
          price: o.price?.toInt() ?? 0,
          currency: o.currency ?? 'RUB',
          priceRUB: o.priceRUB?.toInt(),
          vendorName: _loc(ctx.traderLoc, trader?.name) ?? o.trader ?? '',
          vendorNormalizedName: trader?.normalizedName,
          vendorTypename: 'TraderOffer',
          traderId: o.trader,
          minTraderLevel: o.minTraderLevel?.toInt(),
          taskUnlockId: o.taskUnlock,
        ),
      );
    }
    final flea = item.avg24hPrice?.toInt();
    if (flea != null && flea > 0) {
      out.add(
        ItemPriceInfo(
          price: flea,
          currency: 'RUB',
          priceRUB: flea,
          vendorName: 'Flea Market',
          vendorNormalizedName: 'flea-market',
          vendorTypename: 'FleaMarket',
        ),
      );
    }
    return out;
  }

  String? _json(Object? v) => v == null ? null : jsonEncode(v);

  List<StimEffect> _stim(List<StimEffectApi> effects) => [
    for (final e in effects)
      StimEffect(
        type: e.type ?? '',
        chance: e.chance?.toDouble() ?? 0,
        delay: e.delay?.toInt() ?? 0,
        duration: e.duration?.toInt() ?? 0,
        value: e.value?.toDouble() ?? 0,
        percent: e.percent ?? false,
        skillName: e.skillName,
      ),
  ];

  ItemProperties? _properties(Map<String, dynamic>? raw, ItemMapContext ctx) {
    if (raw == null) return null;
    if (!kKnownPropertiesTypes.contains(raw['propertiesType'])) {
      return const UnknownProperties();
    }
    return switch (PropertiesApi.fromJson(raw)) {
      AmmoPropertiesApi p => AmmoProperties(
        caliber: p.caliber,
        damage: p.damage,
        armorDamage: p.armorDamage,
        penetrationPower: p.penetrationPower,
        projectileCount: p.projectileCount,
        fragmentationChance: p.fragmentationChance?.toDouble(),
        ammoType: p.ammoType,
        tracer: p.tracer,
      ),
      ArmorPropertiesApi p => ArmorProperties(
        armorClass: p.armorClass,
        materialId: p.material,
        materialName: p.material,
        zones: p.zones,
        durability: p.durability,
        ergoPenalty: p.ergoPenalty?.toDouble(),
        speedPenalty: p.speedPenalty?.toDouble(),
        turnPenalty: p.turnPenalty?.toDouble(),
        armorType: p.armorType,
        armorSlotsJson: _json(p.armorSlots),
      ),
      ArmorAttachmentPropertiesApi p => ArmorAttachmentProperties(
        armorClass: p.armorClass,
        materialId: p.material,
        materialName: p.material,
        zones: p.zones,
        durability: p.durability,
        ergoPenalty: p.ergoPenalty?.toDouble(),
        speedPenalty: p.speedPenalty?.toDouble(),
        turnPenalty: p.turnPenalty?.toDouble(),
      ),
      HelmetPropertiesApi p => HelmetProperties(
        armorClass: p.armorClass,
        materialId: p.material,
        materialName: p.material,
        headZones: p.headZones,
        durability: p.durability,
        ergoPenalty: p.ergoPenalty?.toDouble(),
        speedPenalty: p.speedPenalty?.toDouble(),
        turnPenalty: p.turnPenalty?.toDouble(),
        deafening: p.deafening,
        blocksHeadset: p.blocksHeadset,
        blindnessProtection: p.blindnessProtection?.toDouble(),
        ricochetY: p.ricochetY?.toDouble(),
        slotsJson: _json(p.slots),
        armorSlotsJson: _json(p.armorSlots),
      ),
      WeaponPropertiesApi p => WeaponProperties(
        caliber: p.caliber,
        effectiveDistance: p.effectiveDistance,
        ergonomics: p.ergonomics?.toDouble(),
        fireModes: p.fireModes,
        fireRate: p.fireRate,
        recoilVertical: p.recoilVertical,
        recoilHorizontal: p.recoilHorizontal,
        sightingRange: p.sightingRange,
        recoilAngle: p.recoilAngle?.toDouble(),
        recoilDispersion: p.recoilDispersion?.toDouble(),
        convergence: p.convergence?.toDouble(),
        cameraRecoil: p.cameraRecoil?.toDouble(),
        slotsJson: _json(p.slots),
        defaultPresetId: p.defaultPreset,
        presetIds: p.presets,
      ),
      PresetPropertiesApi p => () {
        final base = ctx.items[p.baseItem];
        return PresetProperties(
          baseItemId: p.baseItem,
          baseItemName:
              _loc(ctx.itemLoc, base?.shortName) ??
              _loc(ctx.itemLoc, base?.name),
          baseItemNormalizedName: base?.normalizedName,
          ergonomics: p.ergonomics?.toDouble(),
          recoilVertical: p.recoilVertical,
          recoilHorizontal: p.recoilHorizontal,
        );
      }(),
      MedKitPropertiesApi p => MedKitProperties(
        hitpoints: p.hitpoints,
        useTime: p.useTime,
        maxHealPerUse: p.maxHealPerUse,
        cures: p.cures,
        hpCostLightBleeding: p.hpCostLightBleeding,
        hpCostHeavyBleeding: p.hpCostHeavyBleeding,
      ),
      MedicalItemPropertiesApi p => MedicalItemProperties(
        uses: p.uses,
        useTime: p.useTime,
        cures: p.cures,
      ),
      PainkillerPropertiesApi p => PainkillerProperties(
        uses: p.uses,
        useTime: p.useTime,
        cures: p.cures,
        painkillerDuration: p.painkillerDuration?.toDouble(),
        energyImpact: p.energyImpact,
        hydrationImpact: p.hydrationImpact,
      ),
      SurgicalKitPropertiesApi p => SurgicalKitProperties(
        uses: p.uses,
        useTime: p.useTime,
        cures: p.cures,
        minLimbHealth: p.minLimbHealth?.toDouble(),
        maxLimbHealth: p.maxLimbHealth?.toDouble(),
      ),
      StimPropertiesApi p => StimProperties(
        useTime: p.useTime,
        cures: p.cures,
        stimEffects: _stim(p.stimEffects),
      ),
      FoodDrinkPropertiesApi p => FoodDrinkProperties(
        energy: p.energy,
        hydration: p.hydration,
        units: p.units,
        stimEffects: _stim(p.stimEffects),
      ),
      BackpackPropertiesApi p => BackpackProperties(
        capacity: p.capacity,
        speedPenalty: p.speedPenalty?.toDouble(),
        turnPenalty: p.turnPenalty?.toDouble(),
        ergoPenalty: p.ergoPenalty?.toDouble(),
        gridsJson: _json(p.grids),
      ),
      ContainerPropertiesApi p => ContainerProperties(
        capacity: p.capacity,
        gridsJson: _json(p.grids),
      ),
      ChestRigPropertiesApi p => ChestRigProperties(
        armorClass: p.armorClass,
        materialId: p.material,
        materialName: p.material,
        zones: p.zones,
        durability: p.durability,
        capacity: p.capacity,
        speedPenalty: p.speedPenalty?.toDouble(),
        turnPenalty: p.turnPenalty?.toDouble(),
        ergoPenalty: p.ergoPenalty?.toDouble(),
        gridsJson: _json(p.grids),
        armorSlotsJson: _json(p.armorSlots),
      ),
      GlassesPropertiesApi p => GlassesProperties(
        armorClass: p.armorClass,
        durability: p.durability,
        blindnessProtection: p.blindnessProtection?.toDouble(),
        ergoPenalty: p.ergoPenalty?.toDouble(),
        materialId: p.material,
        materialName: p.material,
      ),
      GrenadePropertiesApi p => GrenadeProperties(
        type: p.type,
        fuse: p.fuse?.toDouble(),
        maxExplosionDistance: p.maxExplosionDistance,
        fragments: p.fragments,
      ),
      HeadphonePropertiesApi p => HeadphoneProperties(
        ambientVolume: p.ambientVolume,
        distortion: p.distortion?.toDouble(),
        distanceModifier: p.distanceModifier?.toDouble(),
      ),
      KeyPropertiesApi p => KeyProperties(uses: p.uses),
      ScopePropertiesApi p => ScopeProperties(
        ergonomics: p.ergonomics?.toDouble(),
        recoilModifier: p.recoilModifier?.toDouble(),
        zoomLevels: [
          for (final l in p.zoomLevels) [for (final v in l) v.toDouble()],
        ],
      ),
      MagazinePropertiesApi p => MagazineProperties(
        ergonomics: p.ergonomics?.toDouble(),
        capacity: p.capacity,
        loadModifier: p.loadModifier?.toDouble(),
        ammoCheckModifier: p.ammoCheckModifier?.toDouble(),
        malfunctionChance: p.malfunctionChance?.toDouble(),
        recoilModifier: p.recoilModifier?.toDouble(),
      ),
      BarrelPropertiesApi p => BarrelProperties(
        ergonomics: p.ergonomics?.toDouble(),
        recoilModifier: p.recoilModifier?.toDouble(),
        slotsJson: _json(p.slots),
      ),
      WeaponModPropertiesApi p => WeaponModProperties(
        ergonomics: p.ergonomics?.toDouble(),
        recoilModifier: p.recoilModifier?.toDouble(),
        accuracyModifier: p.accuracyModifier?.toDouble(),
        slotsJson: _json(p.slots),
      ),
      NightVisionPropertiesApi p => NightVisionProperties(
        intensity: p.intensity?.toDouble(),
        noiseIntensity: p.noiseIntensity?.toDouble(),
        noiseScale: p.noiseScale?.toDouble(),
        diffuseIntensity: p.diffuseIntensity?.toDouble(),
      ),
      MeleePropertiesApi p => MeleeProperties(
        slashDamage: p.slashDamage,
        stabDamage: p.stabDamage,
        hitRadius: p.hitRadius?.toDouble(),
      ),
      ResourcePropertiesApi p => ResourceProperties(units: p.units),
      HeadwearPropertiesApi p => HeadwearProperties(slotsJson: _json(p.slots)),
    };
  }

  ItemsCompanion toItemCompanion(ItemDetailEntity item) {
    String? propsType;
    String? propsJson;
    if (item.properties != null) {
      final propsMap = PropertiesSerializer.toJson(item.properties!);
      propsType = propsMap.remove('type') as String?;
      propsJson = jsonEncode(propsMap);
    }

    return ItemsCompanion.insert(
      id: item.id,
      name: Value(item.name),
      shortName: Value(item.shortName),
      normalizedName: Value(item.normalizedName),
      description: Value(item.description),
      basePrice: Value(item.basePrice),
      backgroundColor: Value(item.backgroundColor),
      width: Value(item.width),
      height: Value(item.height),
      weight: Value(item.weight),
      avg24hPrice: Value(item.avg24hPrice),
      low24hPrice: Value(item.low24hPrice),
      high24hPrice: Value(item.high24hPrice),
      changeLast48h: Value(item.changeLast48h),
      changeLast48hPercent: Value(item.changeLast48hPercent),
      lastLowPrice: Value(item.lastLowPrice),
      lastOfferCount: Value(item.lastOfferCount),
      iconLink: Value(item.iconLink),
      baseImageLink: Value(item.baseImageLink),
      image512pxLink: Value(item.image512pxLink),
      image8xLink: Value(item.image8xLink),
      wikiLink: Value(item.wikiLink),
      bsgCategoryId: Value(item.bsgCategoryId),
      updated: Value(item.updated),
      types: Value(item.types.map((t) => t.name).join(',')),
      propertiesType: Value(propsType),
      propertiesJson: Value(propsJson),
    );
  }

  ItemPricesCompanion toPriceCompanion(
    String itemId,
    String direction,
    ItemPriceInfo price,
  ) {
    String? reqJson;
    if (price.requirements.isNotEmpty) {
      reqJson = jsonEncode(
        price.requirements
            .map((r) => {'type': r.type, 'value': r.value})
            .toList(),
      );
    }

    return ItemPricesCompanion.insert(
      itemId: itemId,
      priceDirection: direction,
      price: price.price,
      currency: price.currency,
      priceRUB: Value(price.priceRUB),
      traderId: Value(price.traderId),
      minTraderLevel: Value(price.minTraderLevel),
      taskUnlockId: Value(price.taskUnlockId),
      requirementsJson: Value(reqJson),
    );
  }

  ItemEntity toItemEntity(Item row) => ItemEntity(
    id: row.id,
    name: row.name,
    shortName: row.shortName,
    basePrice: row.basePrice,
    backgroundColor: row.backgroundColor,
    iconLink: row.iconLink,
    baseImageLink: row.baseImageLink,
    image512pxLink: row.image512pxLink,
    width: row.width,
    height: row.height,
    types: parseTypes(row.types),
    categories: [],
  );

  ItemDetailEntity toItemDetailEntity(
    Item row, {
    required List<ItemCategoryInfo> categories,
    required List<String> handbookCategoryIds,
    required List<ItemPriceInfo> sellFor,
    required List<ItemPriceInfo> buyFor,
    required List<ContainedItem> containsItems,
  }) {
    return ItemDetailEntity(
      id: row.id,
      name: row.name,
      shortName: row.shortName,
      normalizedName: row.normalizedName,
      description: row.description,
      basePrice: row.basePrice,
      avg24hPrice: row.avg24hPrice,
      low24hPrice: row.low24hPrice,
      high24hPrice: row.high24hPrice,
      changeLast48h: row.changeLast48h,
      changeLast48hPercent: row.changeLast48hPercent,
      lastLowPrice: row.lastLowPrice,
      lastOfferCount: row.lastOfferCount,
      width: row.width,
      height: row.height,
      weight: row.weight,
      backgroundColor: row.backgroundColor,
      iconLink: row.iconLink,
      baseImageLink: row.baseImageLink,
      image512pxLink: row.image512pxLink,
      image8xLink: row.image8xLink,
      wikiLink: row.wikiLink,
      bsgCategoryId: row.bsgCategoryId,
      updated: row.updated,
      types: parseTypes(row.types),
      categories: categories,
      handbookCategoryIds: handbookCategoryIds,
      sellFor: sellFor,
      buyFor: buyFor,
      containsItems: containsItems,
      properties: _parseProperties(row),
    );
  }

  ItemPriceInfo toPriceInfo(
    ItemPrice row, {
    Trader? trader,
    String? taskUnlockName,
  }) {
    List<PriceRequirement> requirements = [];
    if (row.requirementsJson != null) {
      try {
        final list = jsonDecode(row.requirementsJson!) as List<dynamic>;
        requirements = list
            .map(
              (r) => PriceRequirement(
                type: r['type'] as String,
                value: r['value'] as int,
              ),
            )
            .toList();
      } catch (_) {}
    }

    final isFlea = row.traderId == null;
    return ItemPriceInfo(
      price: row.price,
      currency: row.currency,
      priceRUB: row.priceRUB,
      vendorName: isFlea ? 'Flea Market' : (trader?.name ?? row.traderId ?? ''),
      vendorNormalizedName: isFlea ? 'flea-market' : trader?.normalizedName,
      vendorTypename: isFlea ? 'FleaMarket' : 'TraderOffer',
      traderId: row.traderId,
      minTraderLevel: row.minTraderLevel,
      taskUnlockId: row.taskUnlockId,
      taskUnlockName: taskUnlockName,
      requirements: requirements,
    );
  }

  AmmoEntity? toAmmoEntity(Item row) {
    final props = _parseProperties(row);
    if (props is! AmmoProperties) return null;
    return AmmoEntity(
      id: row.id,
      name: row.name ?? row.shortName ?? '',
      shortName: row.shortName ?? '',
      iconLink: row.iconLink,
      price: row.avg24hPrice,
      caliber: props.caliber,
      damage: props.damage ?? 0,
      penetrationPower: props.penetrationPower ?? 0,
      armorDamage: props.armorDamage ?? 0,
      fragmentationChance: props.fragmentationChance ?? 0,
      tracer: props.tracer ?? false,
      ammoType: props.ammoType ?? '',
    );
  }

  KeyEntity toKeyEntity(Item row, String? categoryName) => KeyEntity(
    id: row.id,
    name: row.name ?? row.shortName ?? '',
    shortName: row.shortName ?? row.name ?? '',
    iconLink: row.iconLink,
    avgPrice: row.avg24hPrice,
    low24hPrice: row.low24hPrice,
    high24hPrice: row.high24hPrice,
    wikiLink: row.wikiLink,
    categoryName: categoryName,
  );

  FleaItemEntity toFleaEntity(Item row, String? categoryName) => FleaItemEntity(
    id: row.id,
    name: row.name ?? row.shortName ?? '',
    shortName: row.shortName ?? row.name ?? '',
    iconLink: row.iconLink,
    avgPrice: row.avg24hPrice,
    low24hPrice: row.low24hPrice,
    high24hPrice: row.high24hPrice,
    changeLast48h: row.changeLast48h,
    changeLast48hPercent: row.changeLast48hPercent,
    categoryName: categoryName,
  );

  MarketItemEntity toMarketEntity(Item row) => MarketItemEntity(
    id: row.id,
    name: row.name ?? row.shortName ?? row.id,
    shortName: row.shortName ?? row.name ?? row.id,
    avg24hPrice: row.avg24hPrice,
    lastLowPrice: row.lastLowPrice,
    changeLast48hPercent: row.changeLast48hPercent,
  );

  List<ItemType> parseTypes(String typesStr) {
    if (typesStr.isEmpty) return [];
    return typesStr.split(',').map((name) {
      return ItemType.values.firstWhere(
        (t) => t.name == name,
        orElse: () => ItemType.unknown,
      );
    }).toList();
  }

  ItemProperties? _parseProperties(Item row) {
    if (row.propertiesJson == null || row.propertiesType == null) return null;
    try {
      final propsMap = jsonDecode(row.propertiesJson!) as Map<String, dynamic>;
      propsMap['type'] = row.propertiesType;
      return PropertiesSerializer.fromJson(propsMap);
    } catch (_) {
      return null;
    }
  }
}
