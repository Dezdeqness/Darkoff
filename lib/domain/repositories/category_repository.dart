import 'package:darkoff/domain/entities/category_entity.dart';

abstract interface class CategoryRepository {
  Future<Map<String, List<CategoryEntity>>> getCategories();
}
