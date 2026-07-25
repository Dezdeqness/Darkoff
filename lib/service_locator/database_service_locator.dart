import 'package:darkoff/data/local/dao/flea_cache_dao.dart';
import 'package:darkoff/data/mapper/item_mapper.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/local/dao/market_snapshot_dao.dart';
import 'package:darkoff/data/local/dao/reference_dao.dart';
import 'package:darkoff/data/mapper/task_mapper.dart';
import 'package:darkoff/data/local/dao/tasks_dao.dart';
import 'package:darkoff/data/local/database.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupDatabaseServiceLocator() {
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<ItemMapper>(() => ItemMapper());
  getIt.registerLazySingleton<ItemsDao>(
    () => ItemsDao(db: getIt<AppDatabase>(), mapper: getIt<ItemMapper>()),
  );
  getIt.registerLazySingleton<TaskMapper>(() => TaskMapper());
  getIt.registerLazySingleton<TasksDao>(
    () => TasksDao(db: getIt<AppDatabase>(), mapper: getIt<TaskMapper>()),
  );
  getIt.registerLazySingleton<MarketSnapshotDao>(
    () => MarketSnapshotDao(db: getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<FleaCacheDao>(
    () => FleaCacheDao(db: getIt<AppDatabase>()),
  );
  getIt.registerLazySingleton<ReferenceDao>(
    () => ReferenceDao(db: getIt<AppDatabase>()),
  );
}
