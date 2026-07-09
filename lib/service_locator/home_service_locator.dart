import 'package:darkoff/data/cache/market_cache_manager.dart';
import 'package:darkoff/data/local/dao/market_snapshot_dao.dart';
import 'package:darkoff/data/mapper/market_mapper.dart';
import 'package:darkoff/data/repositories/market_repository_impl.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/domain/repositories/market_repository.dart';
import 'package:darkoff/presentation/features/home/mapper/market_item_ui_mapper.dart';
import 'package:darkoff/presentation/features/home/mapper/price_change_ui_mapper.dart';
import 'package:darkoff/presentation/features/home/mapper/server_status_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupHomeServiceLocator() {
  getIt.registerLazySingleton<MarketMapper>(() => MarketMapper());
  getIt.registerLazySingleton<MarketRepository>(
    () => MarketRepositoryImpl(
      service: getIt<DarkoffQLService>(),
      mapper: getIt<MarketMapper>(),
    ),
  );
  getIt.registerLazySingleton<MarketCacheManager>(
    () => MarketCacheManager(
      repository: getIt<MarketRepository>(),
      dao: getIt<MarketSnapshotDao>(),
    ),
  );
  getIt.registerLazySingleton<MarketItemUiMapper>(() => MarketItemUiMapper());
  getIt.registerLazySingleton<PriceChangeUiMapper>(() => PriceChangeUiMapper());
  getIt.registerLazySingleton<ServerStatusUiMapper>(
    () => ServerStatusUiMapper(),
  );
}
