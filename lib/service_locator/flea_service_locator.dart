import 'package:darkoff/data/cache/flea_cache_manager.dart';
import 'package:darkoff/data/datasources/flea/flea_data_source.dart';
import 'package:darkoff/data/local/dao/flea_cache_dao.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/repositories/flea_repository_impl.dart';
import 'package:darkoff/domain/repositories/flea_repository.dart';
import 'package:darkoff/presentation/features/flea_market/mapper/flea_item_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupFleaServiceLocator() {
  getIt.registerLazySingleton<FleaItemUiMapper>(() => FleaItemUiMapper());

  getIt.registerLazySingleton<FleaDataSource>(
    () => FleaDataSource(dao: getIt<ItemsDao>()),
  );

  getIt.registerLazySingleton<FleaRepository>(
    () => FleaRepositoryImpl(dataSource: getIt<FleaDataSource>()),
  );

  getIt.registerLazySingleton<FleaCacheManager>(
    () => FleaCacheManager(
      repository: getIt<FleaRepository>(),
      dao: getIt<FleaCacheDao>(),
    ),
  );
}
