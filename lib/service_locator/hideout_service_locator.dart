import 'package:darkoff/data/local/dao/hideout_progress_dao.dart';
import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/data/mapper/hideout_mapper.dart';
import 'package:darkoff/data/repositories/hideout_progress_repository_impl.dart';
import 'package:darkoff/data/repositories/hideout_repository_impl.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/domain/repositories/hideout_progress_repository.dart';
import 'package:darkoff/domain/repositories/hideout_repository.dart';
import 'package:darkoff/presentation/features/hideout/mapper/hideout_ui_mapper.dart';
import 'package:darkoff/presentation/features/hideout_detail/mapper/hideout_detail_ui_mapper.dart';
import 'package:darkoff/presentation/features/shopping_list/mapper/shopping_list_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupHideoutServiceLocator() {
  getIt.registerLazySingleton<HideoutMapper>(() => HideoutMapper());
  getIt.registerLazySingleton<HideoutUiMapper>(() => HideoutUiMapper());
  getIt.registerLazySingleton<HideoutDetailUiMapper>(
    () => HideoutDetailUiMapper(),
  );
  getIt.registerLazySingleton<ShoppingListUiMapper>(
    () => ShoppingListUiMapper(),
  );

  getIt.registerLazySingleton<HideoutRepository>(
    () => HideoutRepositoryImpl(
      service: getIt<DarkoffQLService>(),
      mapper: getIt<HideoutMapper>(),
    ),
  );

  getIt.registerLazySingleton<HideoutProgressDao>(
    () => HideoutProgressDao(db: getIt<AppDatabase>()),
  );

  getIt.registerLazySingleton<HideoutProgressRepository>(
    () => HideoutProgressRepositoryImpl(dao: getIt<HideoutProgressDao>()),
  );
}
