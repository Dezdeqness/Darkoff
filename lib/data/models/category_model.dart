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

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      key: json['key'] as String,
      displayText: json['displayText'] as String,
      icon: json['icon'] as String,
      type: json['type'] as String,
      types: (json['types'] as List<dynamic>)
          .map((t) => ItemType.values.byName(t as String))
          .toList(),
    );
  }

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
