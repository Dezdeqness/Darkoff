import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:darkoff/presentation/features/items/model/item_ui_model.dart';

class ItemUiMapper {
  ItemUiModel fromEntity(ItemEntity entity) {
    return ItemUiModel(
      id: entity.id,
      displayName: entity.name ?? 'Unknown Item',
      shortName: entity.shortName,
      basePrice: entity.basePrice,
      backgroundColor: entity.backgroundColor,
      iconUrl: entity.iconLink,
      imageUrl: entity.baseImageLink,
      highResImageUrl: entity.image512pxLink,
    );
  }

  List<ItemUiModel> fromEntities(List<ItemEntity> entities) {
    return entities.map(fromEntity).toList();
  }
}
