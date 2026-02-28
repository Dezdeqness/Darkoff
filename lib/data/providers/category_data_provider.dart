import 'dart:convert';

import 'package:darkoff/data/models/category_model.dart';
import 'package:flutter/services.dart';

class CategoryDataProvider {
  Future<Map<String, List<CategoryModel>>> getCategories() async {
    final jsonString = await rootBundle.loadString('assets/categories.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);

    return jsonMap.map(
      (key, value) => MapEntry(
        key,
        (value as List<dynamic>)
            .map((item) =>
                CategoryModel.fromJson(item as Map<String, dynamic>))
            .toList(),
      ),
    );
  }
}
