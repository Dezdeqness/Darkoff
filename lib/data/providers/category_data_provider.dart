import 'package:darkoff/data/models/category_model.dart';

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
      ),
      const CategoryModel(
        key: "helmets",
        displayText: "Helmets",
        icon: "mdiRacingHelmet",
        type: "helmet",
      ),
      const CategoryModel(
        key: "glasses",
        displayText: "Glasses",
        icon: "mdiSunglasses",
        type: "glasses",
      ),
      const CategoryModel(
        key: "armors",
        displayText: "Armors",
        icon: "mdiTshirtCrew",
        type: "armor",
      ),
      const CategoryModel(
        key: "rigs",
        displayText: "Rigs",
        icon: "mdiTshirtCrewOutline",
        type: "rig",
      ),
      const CategoryModel(
        key: "backpacks",
        displayText: "Backpacks",
        icon: "mdiBagPersonal",
        type: "backpack",
      ),
      const CategoryModel(
        key: "guns",
        displayText: "Guns",
        icon: "mdiPistol",
        type: "preset",
      ),
      const CategoryModel(
        key: "mods",
        displayText: "Mods",
        icon: "mdiMagazineRifle",
        type: "mods",
      ),
      const CategoryModel(
        key: "pistol-grips",
        displayText: "Pistol Grips",
        icon: "mdiHandPointingLeft",
        type: "pistolGrip",
      ),
      const CategoryModel(
        key: "suppressors",
        displayText: "Suppressors",
        icon: "mdiBottleWine",
        type: "suppressor",
      ),
      const CategoryModel(
        key: "grenades",
        displayText: "Grenades",
        icon: "mdiGasCylinder",
        type: "grenade",
      ),
      const CategoryModel(
        key: "containers",
        displayText: "Containers",
        icon: "mdiArchive",
        type: "container",
      ),
      const CategoryModel(
        key: "barter-items",
        displayText: "Barter Items",
        icon: "mdiPliers",
        type: "barter",
      ),
      const CategoryModel(
        key: "keys",
        displayText: "Keys",
        icon: "mdiKeyVariant",
        type: "keys",
      ),
      const CategoryModel(
        key: "provisions",
        displayText: "Provisions",
        icon: "mdiFoodForkDrink",
        type: "provisions",
      ),
    ];

    return {
      categoryKeyGear: allCategories.sublist(0, 6),
      categoryKeyWeaponry: allCategories.sublist(6, 11),
      categoryKeyOther: allCategories.sublist(11),
    };
  }
}
