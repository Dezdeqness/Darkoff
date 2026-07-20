import 'package:darkoff/data/cache/flea_cache_manager.dart';
import 'package:darkoff/data/local/dao/flea_cache_dao.dart';
import 'package:darkoff/data/mapper/flea_mapper.dart';
import 'package:darkoff/data/repositories/flea_repository_impl.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/domain/repositories/flea_repository.dart';
import 'package:darkoff/presentation/features/flea_market/mapper/flea_item_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupFleaServiceLocator() {
  getIt.registerLazySingleton<FleaMapper>(() => FleaMapper());
  getIt.registerLazySingleton<FleaItemUiMapper>(() => FleaItemUiMapper());

  getIt.registerLazySingleton<FleaRepository>(
    () => FleaRepositoryImpl(
      service: getIt<DarkoffQLService>(),
      mapper: getIt<FleaMapper>(),
    ),
  );

  getIt.registerLazySingleton<FleaCacheManager>(
    () => FleaCacheManager(
      repository: getIt<FleaRepository>(),
      dao: getIt<FleaCacheDao>(),
    ),
  );
}
