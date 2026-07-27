import 'package:darkoff/data/datasources/ammo/ammo_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/repositories/ammo_repository_impl.dart';
import 'package:darkoff/domain/repositories/ammo_repository.dart';
import 'package:darkoff/presentation/features/ammo/mapper/ammo_chart_ui_mapper.dart';
import 'package:darkoff/presentation/features/ammo/mapper/ammo_list_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupAmmoServiceLocator() {
  getIt.registerLazySingleton<AmmoChartUiMapper>(() => AmmoChartUiMapper());
  getIt.registerLazySingleton<AmmoListUiMapper>(() => AmmoListUiMapper());

  getIt.registerLazySingleton<AmmoDataSource>(
    () => AmmoDataSource(dao: getIt<ItemsDao>()),
  );

  getIt.registerLazySingleton<AmmoRepository>(
    () => AmmoRepositoryImpl(dataSource: getIt<AmmoDataSource>()),
  );
}
