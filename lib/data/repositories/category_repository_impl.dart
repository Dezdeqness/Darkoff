import 'package:darkoff/data/providers/category_data_provider.dart';
import 'package:darkoff/domain/entities/category_entity.dart';
import 'package:darkoff/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl({
    required CategoryDataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  final CategoryDataProvider _dataProvider;

  @override
  Future<Map<String, List<CategoryEntity>>> getCategories() async {
    final categoriesMap = await _dataProvider.getCategories();

    return categoriesMap.map(
      (key, models) => MapEntry(
        key,
        models.map((model) => model.toEntity()).toList(),
      ),
    );
  }
}
