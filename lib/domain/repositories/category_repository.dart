import 'package:darkoff/domain/entities/category_entity.dart';

abstract class CategoryRepository {
  Future<Map<String, List<CategoryEntity>>> getCategories();
}
