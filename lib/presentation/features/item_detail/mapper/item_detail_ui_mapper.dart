import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/presentation/features/item_detail/model/item_detail_ui_model.dart';

class ItemDetailUiMapper {
  ItemDetailUiModel fromEntity(ItemDetailEntity entity) {
    return ItemDetailUiModel(
      id: entity.id,
      displayName: entity.name ?? 'Unknown Item',
      shortName: entity.shortName,
      description: entity.description,
      basePrice: entity.basePrice,
      avg24hPrice: entity.avg24hPrice,
      low24hPrice: entity.low24hPrice,
      high24hPrice: entity.high24hPrice,
      changeLast48hPercent: entity.changeLast48hPercent,
      width: entity.width,
      height: entity.height,
      weight: entity.weight,
      backgroundColor: entity.backgroundColor,
      imageUrl: entity.image512pxLink,
      wikiLink: entity.wikiLink,
      categoryLabel: entity.categories.isNotEmpty
          ? entity.categories.map((c) => c.name).join(', ')
          : '',
      sellFor: entity.sellFor
          .map(
            (s) => PriceUiModel(
              price: s.price,
              currency: s.currency,
              sourceName: s.vendorName,
            ),
          )
          .toList(),
      buyFor: entity.buyFor
          .map(
            (b) => PriceUiModel(
              price: b.price,
              currency: b.currency,
              sourceName: b.vendorName,
            ),
          )
          .toList(),
      properties: entity.properties,
    );
  }
}
