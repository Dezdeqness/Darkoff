
import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:darkoff/domain/entities/item_type.dart';
import 'package:darkoff/presentation/features/items/model/item_ui_model.dart';

class ItemUiMapper {
  ItemUiModel fromEntity(ItemEntity entity) {
    '${formatPrice(entity.basePrice)} ₽';
    return ItemUiModel(
      id: entity.id,
      displayName: entity.name ?? tr.common.item.unknown,
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
    if (types.isEmpty) return tr.items.category.item;
    final primary = types.first;
    return switch (primary) {
      ItemType.barter => tr.items.type.barterItem,
      ItemType.keys || ItemType.markedOnly => tr.items.type.key,
      ItemType.meds || ItemType.injectors => tr.items.type.medicalItem,
      ItemType.ammo || ItemType.ammoBox => tr.items.type.ammo,
      ItemType.armor || ItemType.armorPlate => tr.items.type.armor,
      ItemType.backpack => tr.items.type.backpack,
      ItemType.helmet => tr.items.type.helmet,
      ItemType.rig => tr.items.type.rig,
      ItemType.headphones => tr.items.type.headset,
      ItemType.glasses => tr.items.type.visor,
      ItemType.gun => tr.items.type.weapon,
      ItemType.mods => tr.items.type.mod,
      ItemType.grenade => tr.items.type.grenade,
      ItemType.provisions => tr.items.type.provision,
      ItemType.container => tr.items.type.container,
      ItemType.wearable => tr.items.type.gear,
      _ => tr.items.category.item,
    };
  }
}
