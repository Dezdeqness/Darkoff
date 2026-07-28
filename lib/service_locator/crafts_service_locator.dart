import 'package:darkoff/data/datasources/crafts/crafts_data_source.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/craft_mapper.dart';
import 'package:darkoff/data/repositories/crafts_repository_impl.dart';
import 'package:darkoff/data/service/http/api/crafts_service.dart';
import 'package:darkoff/data/service/http/api/hideout_service.dart';
import 'package:darkoff/domain/repositories/crafts_repository.dart';
import 'package:darkoff/presentation/features/crafts/mapper/crafts_list_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupCraftsServiceLocator() {
  getIt.registerLazySingleton<CraftMapper>(() => CraftMapper());
  getIt.registerLazySingleton<CraftsListUiMapper>(() => CraftsListUiMapper());

  getIt.registerLazySingleton<CraftsDataSource>(
    () => CraftsDataSource(
      craftsService: getIt<CraftsService>(),
      hideoutService: getIt<HideoutService>(),
      localization: getIt<LocalizationDataSource>(),
      itemsDao: getIt<ItemsDao>(),
      mapper: getIt<CraftMapper>(),
    ),
  );

  getIt.registerLazySingleton<CraftsRepository>(
    () => CraftsRepositoryImpl(dataSource: getIt<CraftsDataSource>()),
  );
}
