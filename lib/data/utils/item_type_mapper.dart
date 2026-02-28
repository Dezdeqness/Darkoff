import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/item_type.dart';

const _mapping = {
  ItemType.ammo: Enum$ItemType.ammo,
  ItemType.ammoBox: Enum$ItemType.ammoBox,
  ItemType.any: Enum$ItemType.any,
  ItemType.armor: Enum$ItemType.armor,
  ItemType.armorPlate: Enum$ItemType.armorPlate,
  ItemType.backpack: Enum$ItemType.backpack,
  ItemType.barter: Enum$ItemType.barter,
  ItemType.container: Enum$ItemType.container,
  ItemType.glasses: Enum$ItemType.glasses,
  ItemType.grenade: Enum$ItemType.grenade,
  ItemType.gun: Enum$ItemType.gun,
  ItemType.headphones: Enum$ItemType.headphones,
  ItemType.helmet: Enum$ItemType.helmet,
  ItemType.injectors: Enum$ItemType.injectors,
  ItemType.keys: Enum$ItemType.keys,
  ItemType.markedOnly: Enum$ItemType.markedOnly,
  ItemType.meds: Enum$ItemType.meds,
  ItemType.mods: Enum$ItemType.mods,
  ItemType.noFlea: Enum$ItemType.noFlea,
  ItemType.pistolGrip: Enum$ItemType.pistolGrip,
  ItemType.poster: Enum$ItemType.poster,
  ItemType.preset: Enum$ItemType.preset,
  ItemType.provisions: Enum$ItemType.provisions,
  ItemType.rig: Enum$ItemType.rig,
  ItemType.specialSlot: Enum$ItemType.specialSlot,
  ItemType.suppressor: Enum$ItemType.suppressor,
  ItemType.wearable: Enum$ItemType.wearable,
  ItemType.unknown: Enum$ItemType.$unknown,
};

final _reverseMapping = {
  for (final entry in _mapping.entries) entry.value: entry.key,
};

extension ItemTypeUtils on ItemType {
  static ItemType fromGraphqlEnum(Enum$ItemType graphqlType) =>
      _reverseMapping[graphqlType] ?? ItemType.unknown;

  Enum$ItemType toGraphqlEnum() =>
      _mapping[this] ?? Enum$ItemType.$unknown;
}
