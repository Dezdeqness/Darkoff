import 'package:darkoff/domain/entities/category_entity.dart';
import 'package:darkoff/domain/entities/item_type.dart';

class CategoryModel {
  final String key;
  final String displayText;
  final String icon;
  final String type;
  final List<ItemType> types;

  const CategoryModel({
    required this.key,
    required this.displayText,
    required this.icon,
    required this.type,
    required this.types,
  });

  CategoryEntity toEntity() {
    return CategoryEntity(
      key: key,
      displayText: displayText,
      icon: icon,
      type: type,
      types: types,
    );
  }
}
