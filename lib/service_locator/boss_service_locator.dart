import 'package:darkoff/data/datasources/boss/boss_data_source.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/mapper/boss_mapper.dart';
import 'package:darkoff/data/repositories/boss_repository_impl.dart';
import 'package:darkoff/data/service/http/api/maps_service.dart';
import 'package:darkoff/domain/repositories/boss_repository.dart';
import 'package:darkoff/presentation/features/boss_detail/mapper/boss_detail_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupBossServiceLocator() {
  getIt.registerLazySingleton<BossMapper>(() => const BossMapper());
  getIt.registerLazySingleton<BossDetailUiMapper>(() => BossDetailUiMapper());

  getIt.registerLazySingleton<BossDataSource>(
    () => BossDataSource(
      mapsService: getIt<MapsService>(),
      localization: getIt<LocalizationDataSource>(),
      mapper: getIt<BossMapper>(),
    ),
  );

  getIt.registerLazySingleton<BossRepository>(
    () => BossRepositoryImpl(dataSource: getIt<BossDataSource>()),
  );
}
