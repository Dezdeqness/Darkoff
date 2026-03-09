import 'package:darkoff/domain/entities/category_entity.dart';

class CategoryModel {
  final String key;
  final String displayText;
  final String icon;
  final List<String> categoryNames;

  const CategoryModel({
    required this.key,
    required this.displayText,
    required this.icon,
    required this.categoryNames,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      key: json['key'] as String,
      displayText: json['displayText'] as String,
      icon: json['icon'] as String,
      categoryNames: (json['categoryNames'] as List<dynamic>)
          .map((t) => t as String)
          .toList(),
    );
  }

  CategoryEntity toEntity() {
    return CategoryEntity(
      key: key,
      displayText: displayText,
      icon: icon,
      categoryNames: categoryNames,
    );
  }
}
