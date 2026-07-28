import 'package:darkoff/data/datasources/barters/barters_data_source.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/barter_mapper.dart';
import 'package:darkoff/data/repositories/barters_repository_impl.dart';
import 'package:darkoff/data/service/http/api/barters_service.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/domain/repositories/barters_repository.dart';
import 'package:darkoff/presentation/features/barters/mapper/barters_list_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupBartersServiceLocator() {
  getIt.registerLazySingleton<BarterMapper>(() => BarterMapper());
  getIt.registerLazySingleton<BartersListUiMapper>(
    () => BartersListUiMapper(),
  );

  getIt.registerLazySingleton<BartersDataSource>(
    () => BartersDataSource(
      bartersService: getIt<BartersService>(),
      tradersService: getIt<TradersService>(),
      localization: getIt<LocalizationDataSource>(),
      itemsDao: getIt<ItemsDao>(),
      mapper: getIt<BarterMapper>(),
    ),
  );

  getIt.registerLazySingleton<BartersRepository>(
    () => BartersRepositoryImpl(dataSource: getIt<BartersDataSource>()),
  );
}
