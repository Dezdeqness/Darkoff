import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:darkoff/domain/entities/item_type.dart';
import 'package:darkoff/presentation/features/items/model/item_ui_model.dart';

class ItemUiMapper {
  ItemUiModel fromEntity(ItemEntity entity) {
    '${formatPrice(entity.basePrice)} ₽';
    return ItemUiModel(
      id: entity.id,
      displayName: entity.name ?? 'Unknown Item',
      shortName: entity.shortName,
      displayPrice: '${formatPrice(entity.basePrice)} ₽',
      backgroundColor: entity.backgroundColor,
      iconUrl: entity.iconLink,
      imageUrl: entity.baseImageLink,
      highResImageUrl: entity.image512pxLink,
      categoryLabel: buildSubtitle(entity),
    );
  }

  List<ItemUiModel> fromEntities(List<ItemEntity> entities) {
    return entities.map(fromEntity).toList();
  }

  String buildSubtitle(ItemEntity entity) {
    final category = _categoryLabel(entity.types);
    final w = entity.width;
    final h = entity.height;
    if (w != null && h != null) {
      return '$category · ${w}x$h';
    }
    return category;
  }

  String _categoryLabel(List<ItemType> types) {
    if (types.isEmpty) return 'Item';
    final primary = types.first;
    return switch (primary) {
      ItemType.barter => 'Barter item',
      ItemType.keys || ItemType.markedOnly => 'Key',
      ItemType.meds || ItemType.injectors => 'Medical item',
      ItemType.ammo || ItemType.ammoBox => 'Ammo',
      ItemType.armor || ItemType.armorPlate => 'Armor',
      ItemType.backpack => 'Backpack',
      ItemType.helmet => 'Helmet',
      ItemType.rig => 'Rig',
      ItemType.headphones => 'Headset',
      ItemType.glasses => 'Visor',
      ItemType.gun => 'Weapon',
      ItemType.mods => 'Mod',
      ItemType.grenade => 'Grenade',
      ItemType.provisions => 'Provision',
      ItemType.container => 'Container',
      ItemType.wearable => 'Gear',
      _ => 'Item',
    };
  }
}
