import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/datasources/server_status/server_status_data_source.dart';
import 'package:darkoff/data/datasources/tasks/tasks_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/local/dao/tasks_dao.dart';
import 'package:darkoff/data/mapper/task_mapper.dart';
import 'package:darkoff/data/repositories/server_status_repository_impl.dart';
import 'package:darkoff/data/repositories/tasks_repository_impl.dart';
import 'package:darkoff/data/service/http/api/tasks_service.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/data/service/http/api/status_service.dart';
import 'package:server_status_contract/server_status_contract.dart';
import 'package:tasks_contract/tasks_contract.dart';
import 'package:darkoff/presentation/features/task_detail/mapper/task_detail_ui_mapper.dart';
import 'package:darkoff/presentation/features/tasks/mapper/task_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupTasksServiceLocator() {
  getIt.registerLazySingleton<TaskUiMapper>(() => TaskUiMapper());
  getIt.registerLazySingleton<TaskDetailUiMapper>(() => TaskDetailUiMapper());

  getIt.registerLazySingleton<TasksDataSource>(
    () => TasksDataSource(
      tasksService: getIt<TasksService>(),
      tradersService: getIt<TradersService>(),
      localization: getIt<LocalizationDataSource>(),
      itemsDao: getIt<ItemsDao>(),
      mapper: getIt<TaskMapper>(),
    ),
  );

  getIt.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(
      dataSource: getIt<TasksDataSource>(),
      dao: getIt<TasksDao>(),
    ),
  );

  getIt.registerLazySingleton<ServerStatusDataSource>(
    () => ServerStatusDataSource(statusService: getIt<StatusService>()),
  );

  getIt.registerLazySingleton<ServerStatusRepository>(
    () =>
        ServerStatusRepositoryImpl(dataSource: getIt<ServerStatusDataSource>()),
  );
}
