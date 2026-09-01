import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/datasources/maps/maps_data_source.dart';
import 'package:darkoff/data/mapper/map_mapper.dart';
import 'package:darkoff/data/repositories/maps_repository_impl.dart';
import 'package:darkoff/data/service/http/api/maps_service.dart';
import 'package:maps_contract/maps_contract.dart';
import 'package:darkoff/presentation/features/maps/mapper/map_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupMapsServiceLocator() {
  getIt.registerLazySingleton<MapUiMapper>(() => MapUiMapper());
  getIt.registerLazySingleton<MapMapper>(() => const MapMapper());

  getIt.registerLazySingleton<MapsDataSource>(
    () => MapsDataSource(
      mapsService: getIt<MapsService>(),
      localization: getIt<LocalizationDataSource>(),
      mapper: getIt<MapMapper>(),
    ),
  );

  getIt.registerLazySingleton<MapsRepository>(
    () => MapsRepositoryImpl(dataSource: getIt<MapsDataSource>()),
  );
}
