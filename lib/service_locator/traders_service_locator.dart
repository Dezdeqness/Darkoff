import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/datasources/traders/traders_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/trader_mapper.dart';
import 'package:darkoff/data/repositories/traders_repository_impl.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/data/service/http/api/barters_service.dart';
import 'package:darkoff/domain/repositories/traders_repository.dart';
import 'package:darkoff/presentation/features/traders/mapper/trader_list_ui_mapper.dart';
import 'package:darkoff/presentation/features/traders_detail/mapper/trader_detail_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupTradersServiceLocator() {
  getIt.registerLazySingleton<TraderMapper>(() => TraderMapper());
  getIt.registerLazySingleton<TraderListUiMapper>(() => TraderListUiMapper());
  getIt.registerLazySingleton<TraderDetailUiMapper>(
    () => TraderDetailUiMapper(),
  );

  getIt.registerLazySingleton<TradersDataSource>(
    () => TradersDataSource(
      tradersService: getIt<TradersService>(),
      bartersService: getIt<BartersService>(),
      localization: getIt<LocalizationDataSource>(),
      itemsDao: getIt<ItemsDao>(),
      mapper: getIt<TraderMapper>(),
    ),
  );

  getIt.registerLazySingleton<TradersRepository>(
    () => TradersRepositoryImpl(dataSource: getIt<TradersDataSource>()),
  );
}
