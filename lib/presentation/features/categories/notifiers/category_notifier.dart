import 'package:darkoff/service_locator/categories_service_locator.dart';
import 'package:darkoff/domain/repositories/category_repository.dart';
import 'package:darkoff/presentation/features/categories/mapper/category_ui_mapper.dart';
import 'package:darkoff/presentation/features/categories/state/category_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_notifier.g.dart';

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  late CategoryRepository _repository;
  late CategoryUiMapper _mapper;

  @override
  CategoryState build() {
    _repository = getIt<CategoryRepository>();
    _mapper = getIt<CategoryUiMapper>();
    loadCategories();
    return const CategoryState.initial();
  }

  Future<void> loadCategories() async {
    state = const CategoryState.loading();
    
    final categoriesMap = await _repository.getCategories();
    final sections = _mapper.mapToSections(categoriesMap);
    
    state = CategoryState.loaded(sections);
  }
}
