import 'package:darkoff/data/models/category_model.dart';
import 'package:darkoff/domain/entities/item_type.dart';

const categoryKeyGear = 'gear';
const categoryKeyWeaponry = 'weaponry';
const categoryKeyOther = 'other_stuff';

class CategoryDataProvider {
  Map<String, List<CategoryModel>> getCategories() {
    final allCategories = [
      const CategoryModel(
        key: "headsets",
        displayText: "Headsets",
        icon: "mdiHeadset",
        type: "headphones",
        types: [ItemType.headphones],
      ),
      const CategoryModel(
        key: "helmets",
        displayText: "Helmets",
        icon: "mdiRacingHelmet",
        type: "helmet",
        types: [ItemType.helmet],
      ),
      const CategoryModel(
        key: "glasses",
        displayText: "Glasses",
        icon: "mdiSunglasses",
        type: "glasses",
        types: [ItemType.glasses],
      ),
      const CategoryModel(
        key: "armors",
        displayText: "Armors",
        icon: "mdiTshirtCrew",
        type: "armor",
        types: [ItemType.armor, ItemType.armorPlate],
      ),
      const CategoryModel(
        key: "rigs",
        displayText: "Rigs",
        icon: "mdiTshirtCrewOutline",
        type: "rig",
        types: [ItemType.rig],
      ),
      const CategoryModel(
        key: "backpacks",
        displayText: "Backpacks",
        icon: "mdiBagPersonal",
        type: "backpack",
        types: [ItemType.backpack],
      ),
      const CategoryModel(
        key: "guns",
        displayText: "Guns",
        icon: "mdiPistol",
        type: "preset",
        types: [ItemType.preset],
      ),
      const CategoryModel(
        key: "ammo",
        displayText: "Ammo",
        icon: "mdiBullet",
        type: "ammo",
        types: [ItemType.ammo, ItemType.ammoBox],
      ),
      const CategoryModel(
        key: "mods",
        displayText: "Mods",
        icon: "mdiMagazineRifle",
        type: "mods",
        types: [ItemType.mods],
      ),
      const CategoryModel(
        key: "pistol-grips",
        displayText: "Pistol Grips",
        icon: "mdiHandPointingLeft",
        type: "pistolGrip",
        types: [ItemType.pistolGrip],
      ),
      const CategoryModel(
        key: "suppressors",
        displayText: "Suppressors",
        icon: "mdiBottleWine",
        type: "suppressor",
        types: [ItemType.suppressor],
      ),
      const CategoryModel(
        key: "grenades",
        displayText: "Grenades",
        icon: "mdiGasCylinder",
        type: "grenade",
        types: [ItemType.grenade],
      ),
      const CategoryModel(
        key: "containers",
        displayText: "Containers",
        icon: "mdiArchive",
        type: "container",
        types: [ItemType.container],
      ),
      const CategoryModel(
        key: "barter-items",
        displayText: "Barter Items",
        icon: "mdiPliers",
        type: "barter",
        types: [ItemType.barter],
      ),
      const CategoryModel(
        key: "keys",
        displayText: "Keys",
        icon: "mdiKeyVariant",
        type: "keys",
        types: [ItemType.keys],
      ),
      const CategoryModel(
        key: "provisions",
        displayText: "Provisions",
        icon: "mdiFoodForkDrink",
        type: "provisions",
        types: [ItemType.provisions, ItemType.meds, ItemType.injectors],
      ),
    ];

    return {
      categoryKeyGear: allCategories.sublist(0, 6),
      categoryKeyWeaponry: allCategories.sublist(6, 11),
      categoryKeyOther: allCategories.sublist(11),
    };
  }
}
