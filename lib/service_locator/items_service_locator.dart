import 'package:darkoff/data/datasources/items/items_data_source.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/item_mapper.dart';
import 'package:darkoff/data/repositories/items_repository_impl.dart';
import 'package:darkoff/data/service/http/api/items_service.dart';
import 'package:darkoff/data/service/http/api/prices_service.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:darkoff/domain/usecases/get_item_detail_usecase.dart';
import 'package:darkoff/presentation/features/item_detail/mapper/item_detail_ui_mapper.dart';
import 'package:darkoff/presentation/features/items/mapper/item_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupItemsServiceLocator() {
  getIt.registerLazySingleton<ItemUiMapper>(() => ItemUiMapper());
  getIt.registerLazySingleton<ItemDetailUiMapper>(() => ItemDetailUiMapper());

  getIt.registerLazySingleton<ItemsDataSource>(
    () => ItemsDataSource(
      itemsService: getIt<ItemsService>(),
      tradersService: getIt<TradersService>(),
      localization: getIt<LocalizationDataSource>(),
      pricesService: getIt<PricesService>(),
      mapper: getIt<ItemMapper>(),
      dao: getIt<ItemsDao>(),
    ),
  );

  getIt.registerLazySingleton<ItemsRepository>(
    () => ItemsRepositoryImpl(
      dataSource: getIt<ItemsDataSource>(),
      dao: getIt<ItemsDao>(),
    ),
  );

  getIt.registerLazySingleton<GetItemDetailUseCase>(
    () => GetItemDetailUseCase(repository: getIt<ItemsRepository>()),
  );
}
