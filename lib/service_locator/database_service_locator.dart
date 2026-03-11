import 'package:darkoff/data/local/dao/item_db_mapper.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/data/service/preload_service.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

void setupDatabaseServiceLocator() {
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<ItemDbMapper>(() => ItemDbMapper());
  getIt.registerLazySingleton<ItemsDao>(
    () => ItemsDao(
      db: getIt<AppDatabase>(),
      mapper: getIt<ItemDbMapper>(),
    ),
  );
}

void setupPreloadServiceLocator() {
  getIt.registerLazySingleton<PreloadService>(
    () => PreloadService(
      repository: getIt<ItemsRepository>(),
      dao: getIt<ItemsDao>(),
      logger: getIt<Logger>(),
    ),
  );
}
