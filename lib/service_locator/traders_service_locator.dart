import 'package:darkoff/data/mapper/trader_mapper.dart';
import 'package:darkoff/data/repositories/traders_repository_impl.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/domain/repositories/traders_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupTradersServiceLocator() {
  getIt.registerLazySingleton<TraderMapper>(() => TraderMapper());

  getIt.registerLazySingleton<TradersRepository>(
    () => TradersRepositoryImpl(
      service: getIt<DarkoffQLService>(),
      mapper: getIt<TraderMapper>(),
    ),
  );
}
