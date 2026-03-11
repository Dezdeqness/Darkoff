import 'package:darkoff/data/providers/category_data_provider.dart';
import 'package:darkoff/data/repositories/category_repository_impl.dart';
import 'package:darkoff/domain/repositories/category_repository.dart';
import 'package:darkoff/presentation/features/categories/mapper/category_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupCategoriesServiceLocator() {
  getIt.registerLazySingleton<CategoryDataProvider>(() => CategoryDataProvider());

  getIt.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(dataProvider: getIt<CategoryDataProvider>()),
  );

  getIt.registerLazySingleton<CategoryUiMapper>(() => CategoryUiMapper());
}
