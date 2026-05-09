import 'dart:convert';

import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/data/local/dao/helpers/properties_serializer.dart';
import 'package:darkoff/domain/entities/item_category_info.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:darkoff/domain/entities/item_type.dart';
import 'package:drift/drift.dart';

class ItemDbMapper {

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
      String itemId, String direction, ItemPriceInfo price) {
    String? reqJson;
    if (price.requirements.isNotEmpty) {
      reqJson = jsonEncode(
          price.requirements
              .map((r) => {'type': r.type, 'value': r.value})
              .toList());
    }

    return ItemPricesCompanion.insert(
      itemId: itemId,
      priceDirection: direction,
      price: price.price,
      currency: price.currency,
      priceRUB: Value(price.priceRUB),
      vendorName: price.vendorName,
      vendorNormalizedName: Value(price.vendorNormalizedName),
      vendorTypename: Value(price.vendorTypename),
      traderId: Value(price.traderId),
      minTraderLevel: Value(price.minTraderLevel),
      taskUnlockId: Value(price.taskUnlockId),
      taskUnlockName: Value(price.taskUnlockName),
      taskUnlockNormalizedName: Value(price.taskUnlockNormalizedName),
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

  ItemPriceInfo toPriceInfo(ItemPrice row) {
    List<PriceRequirement> requirements = [];
    if (row.requirementsJson != null) {
      try {
        final list = jsonDecode(row.requirementsJson!) as List<dynamic>;
        requirements = list
            .map((r) => PriceRequirement(
                  type: r['type'] as String,
                  value: r['value'] as int,
                ))
            .toList();
      } catch (_) {}
    }

    return ItemPriceInfo(
      price: row.price,
      currency: row.currency,
      priceRUB: row.priceRUB,
      vendorName: row.vendorName,
      vendorNormalizedName: row.vendorNormalizedName,
      vendorTypename: row.vendorTypename,
      traderId: row.traderId,
      minTraderLevel: row.minTraderLevel,
      taskUnlockId: row.taskUnlockId,
      taskUnlockName: row.taskUnlockName,
      taskUnlockNormalizedName: row.taskUnlockNormalizedName,
      requirements: requirements,
    );
  }

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
      final propsMap =
          jsonDecode(row.propertiesJson!) as Map<String, dynamic>;
      propsMap['type'] = row.propertiesType;
      return PropertiesSerializer.fromJson(propsMap);
    } catch (_) {
      return null;
    }
  }
}
