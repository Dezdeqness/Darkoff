import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/item_detail_mapper.dart';
import 'package:darkoff/data/repositories/items_repository_impl.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:darkoff/domain/usecases/get_item_detail_usecase.dart';
import 'package:darkoff/presentation/features/home/mapper/market_item_ui_mapper.dart';
import 'package:darkoff/presentation/features/item_detail/mapper/item_detail_ui_mapper.dart';
import 'package:darkoff/presentation/features/items/mapper/item_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupItemsServiceLocator() {
  getIt.registerLazySingleton<ItemDetailMapper>(() => ItemDetailMapper());
  getIt.registerLazySingleton<ItemUiMapper>(() => ItemUiMapper());
  getIt.registerLazySingleton<ItemDetailUiMapper>(() => ItemDetailUiMapper());
  getIt.registerLazySingleton<MarketItemUiMapper>(() => MarketItemUiMapper());

  getIt.registerLazySingleton<ItemsRepository>(
    () => ItemsRepositoryImpl(
      service: getIt<DarkoffQLService>(),
      detailMapper: getIt<ItemDetailMapper>(),
      dao: getIt<ItemsDao>(),
    ),
  );

  getIt.registerLazySingleton<GetItemDetailUseCase>(
    () => GetItemDetailUseCase(
      repository: getIt<ItemsRepository>(),
    ),
  );
}
