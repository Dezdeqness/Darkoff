import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/item_type.dart';

extension ItemTypeUtils on ItemType {
  static ItemType fromGraphqlEnum(Enum$ItemType graphqlType) {
    switch (graphqlType) {
      case Enum$ItemType.ammo:
        return ItemType.ammo;
      case Enum$ItemType.ammoBox:
        return ItemType.ammoBox;
      case Enum$ItemType.any:
        return ItemType.any;
      case Enum$ItemType.armor:
        return ItemType.armor;
      case Enum$ItemType.armorPlate:
        return ItemType.armorPlate;
      case Enum$ItemType.backpack:
        return ItemType.backpack;
      case Enum$ItemType.barter:
        return ItemType.barter;
      case Enum$ItemType.container:
        return ItemType.container;
      case Enum$ItemType.glasses:
        return ItemType.glasses;
      case Enum$ItemType.grenade:
        return ItemType.grenade;
      case Enum$ItemType.gun:
        return ItemType.gun;
      case Enum$ItemType.headphones:
        return ItemType.headphones;
      case Enum$ItemType.helmet:
        return ItemType.helmet;
      case Enum$ItemType.injectors:
        return ItemType.injectors;
      case Enum$ItemType.keys:
        return ItemType.keys;
      case Enum$ItemType.markedOnly:
        return ItemType.markedOnly;
      case Enum$ItemType.meds:
        return ItemType.meds;
      case Enum$ItemType.mods:
        return ItemType.mods;
      case Enum$ItemType.noFlea:
        return ItemType.noFlea;
      case Enum$ItemType.pistolGrip:
        return ItemType.pistolGrip;
      case Enum$ItemType.poster:
        return ItemType.poster;
      case Enum$ItemType.preset:
        return ItemType.preset;
      case Enum$ItemType.provisions:
        return ItemType.provisions;
      case Enum$ItemType.rig:
        return ItemType.rig;
      case Enum$ItemType.specialSlot:
        return ItemType.specialSlot;
      case Enum$ItemType.suppressor:
        return ItemType.suppressor;
      case Enum$ItemType.wearable:
        return ItemType.wearable;
      case Enum$ItemType.$unknown:
        return ItemType.unknown;
    }
  }

  Enum$ItemType toGraphqlEnum() {
    switch (this) {
      case ItemType.ammo:
        return Enum$ItemType.ammo;
      case ItemType.ammoBox:
        return Enum$ItemType.ammoBox;
      case ItemType.any:
        return Enum$ItemType.any;
      case ItemType.armor:
        return Enum$ItemType.armor;
      case ItemType.armorPlate:
        return Enum$ItemType.armorPlate;
      case ItemType.backpack:
        return Enum$ItemType.backpack;
      case ItemType.barter:
        return Enum$ItemType.barter;
      case ItemType.container:
        return Enum$ItemType.container;
      case ItemType.glasses:
        return Enum$ItemType.glasses;
      case ItemType.grenade:
        return Enum$ItemType.grenade;
      case ItemType.gun:
        return Enum$ItemType.gun;
      case ItemType.headphones:
        return Enum$ItemType.headphones;
      case ItemType.helmet:
        return Enum$ItemType.helmet;
      case ItemType.injectors:
        return Enum$ItemType.injectors;
      case ItemType.keys:
        return Enum$ItemType.keys;
      case ItemType.markedOnly:
        return Enum$ItemType.markedOnly;
      case ItemType.meds:
        return Enum$ItemType.meds;
      case ItemType.mods:
        return Enum$ItemType.mods;
      case ItemType.noFlea:
        return Enum$ItemType.noFlea;
      case ItemType.pistolGrip:
        return Enum$ItemType.pistolGrip;
      case ItemType.poster:
        return Enum$ItemType.poster;
      case ItemType.preset:
        return Enum$ItemType.preset;
      case ItemType.provisions:
        return Enum$ItemType.provisions;
      case ItemType.rig:
        return Enum$ItemType.rig;
      case ItemType.specialSlot:
        return Enum$ItemType.specialSlot;
      case ItemType.suppressor:
        return Enum$ItemType.suppressor;
      case ItemType.wearable:
        return Enum$ItemType.wearable;
      case ItemType.unknown:
        return Enum$ItemType.$unknown;
    }
  }
}
