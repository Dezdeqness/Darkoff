import 'package:darkoff/domain/entities/category_entity.dart';

class CategoryModel {
  final String key;
  final String displayText;
  final String icon;
  final String type;

  const CategoryModel({
    required this.key,
    required this.displayText,
    required this.icon,
    required this.type,
  });

  CategoryEntity toEntity() {
    return CategoryEntity(
      key: key,
      displayText: displayText,
      icon: icon,
      type: type,
    );
  }
}
