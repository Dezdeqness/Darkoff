import 'package:darkoff/data/mapper/ammo_mapper.dart';
import 'package:darkoff/data/repositories/ammo_repository_impl.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/domain/repositories/ammo_repository.dart';
import 'package:darkoff/presentation/features/ammo/mapper/ammo_chart_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupAmmoServiceLocator() {
  getIt.registerLazySingleton<AmmoMapper>(() => AmmoMapper());
  getIt.registerLazySingleton<AmmoChartUiMapper>(() => AmmoChartUiMapper());

  getIt.registerLazySingleton<AmmoRepository>(
    () => AmmoRepositoryImpl(
      service: getIt<DarkoffQLService>(),
      mapper: getIt<AmmoMapper>(),
    ),
  );
}
