import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/presentation/features/core/model/property_tile_ui_model.dart';
import 'package:darkoff/presentation/features/item_detail/model/item_detail_ui_model.dart';

class ItemDetailUiMapper {
  ItemDetailUiModel fromEntity(ItemDetailEntity entity) {
    final fleaPrice = entity.avg24hPrice ?? entity.basePrice;

    final properties = _buildProperties(entity);
    final prices = <PriceRowUiModel>[
      PriceRowUiModel(
        label: tr.common.price.fleaMarket,
        price: '${formatPrice(fleaPrice)} ₽',
        badge: entity.changeLast48hPercent != null
            ? '${entity.changeLast48hPercent! >= 0 ? '+' : ''}'
                  '${entity.changeLast48hPercent!.toStringAsFixed(1)}%'
            : null,
        positiveBadge: (entity.changeLast48hPercent ?? 0) >= 0,
        highlight: true,
      ),
    ];

    if (entity.sellFor.isNotEmpty) {
      final best = entity.sellFor.first;

      prices.add(
        PriceRowUiModel(
          label: tr.itemDetail.sellToVendor(vendor: best.vendorName),
          price: '${formatPrice(best.price)} ${currencySymbol(best.currency)}',
        ),
      );
    }

    final sellPrices = entity.sellFor.map((item) {
      return SellPriceUiModel(
        vendor: item.vendorName,
        price: '${formatPrice(item.price)} ${currencySymbol(item.currency)}',
      );
    }).toList();

    final labels = <String>[
      if (entity.width != null && entity.height != null)
        '${entity.width}x${entity.height}',
      if (entity.weight != null) '${entity.weight!.toStringAsFixed(1)} kg',
    ];

    return ItemDetailUiModel(
      id: entity.id,
      displayName: entity.name ?? tr.common.item.unknown,
      shortName: entity.shortName,
      labels: labels,
      description: entity.description,
      categoryLabel: entity.categories.map((item) => item.name).join(', '),
      backgroundColor: entity.backgroundColor,
      imageUrl: entity.image512pxLink,
      wikiLink: entity.wikiLink,
      prices: prices,
      properties: properties,
      sellPrices: sellPrices,
      itemProperties: entity.properties,
    );
  }

  List<PropertyTileUiModel> _buildProperties(ItemDetailEntity entity) {
    final profit = entity.avg24hPrice != null && entity.sellFor.isNotEmpty
        ? entity.avg24hPrice! - entity.sellFor.first.price
        : null;

    final slots =
        entity.width != null &&
            entity.height != null &&
            entity.width! > 0 &&
            entity.height! > 0
        ? entity.width! * entity.height!
        : null;

    final fleaPrice = entity.avg24hPrice ?? entity.basePrice;

    final perSlot = slots != null && slots > 0 ? fleaPrice ~/ slots : null;

    return <PropertyTileUiModel>[
      if (entity.width != null && entity.height != null)
        PropertyTileUiModel(
          label: tr.itemDetail.property.size,
          value: '${entity.width} x ${entity.height}',
        ),

      if (entity.weight != null)
        PropertyTileUiModel(
          label: tr.itemDetail.property.weight,
          value: '${entity.weight!.toStringAsFixed(1)} kg',
        ),

      if (profit != null)
        PropertyTileUiModel(
          label: tr.itemDetail.property.profit,
          value: '${profit >= 0 ? '+' : ''}${formatPrice(profit)} ₽',
          type: profit >= 0
              ? PropertyValueType.positive
              : PropertyValueType.negative,
        ),

      if (perSlot != null)
        PropertyTileUiModel(
          label: tr.itemDetail.property.perSlot,
          value: '${formatPrice(perSlot)} ₽',
          type: PropertyValueType.accent,
        ),
    ];
  }
}
