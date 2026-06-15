import 'package:darkoff/data/local/dao/tasks_dao.dart';
import 'package:darkoff/data/mapper/status_mapper.dart';
import 'package:darkoff/data/mapper/task_mapper.dart';
import 'package:darkoff/data/repositories/server_status_repository_impl.dart';
import 'package:darkoff/data/repositories/tasks_repository_impl.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/domain/repositories/server_status_repository.dart';
import 'package:darkoff/domain/repositories/tasks_repository.dart';
import 'package:darkoff/presentation/features/tasks/mapper/task_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupTasksServiceLocator() {
  getIt.registerLazySingleton<TaskMapper>(() => TaskMapper());
  getIt.registerLazySingleton<TaskUiMapper>(() => TaskUiMapper());
  getIt.registerLazySingleton<StatusMapper>(() => StatusMapper());

  getIt.registerLazySingleton<TasksRepository>(
    () => TasksRepositoryImpl(
      service: getIt<DarkoffQLService>(),
      mapper: getIt<TaskMapper>(),
      dao: getIt<TasksDao>(),
    ),
  );

  getIt.registerLazySingleton<ServerStatusRepository>(
    () => ServerStatusRepositoryImpl(
      service: getIt<DarkoffQLService>(),
      mapper: getIt<StatusMapper>(),
    ),
  );
}
