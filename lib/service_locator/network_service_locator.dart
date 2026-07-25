import 'package:darkoff/core/config/app_config.dart';
import 'package:darkoff/data/service/http/api/barters_service.dart';
import 'package:darkoff/data/service/http/api/crafts_service.dart';
import 'package:darkoff/data/service/http/api/hideout_service.dart';
import 'package:darkoff/data/service/http/api/items_service.dart';
import 'package:darkoff/data/service/http/api/localization_service.dart';
import 'package:darkoff/data/service/http/api/maps_service.dart';
import 'package:darkoff/data/service/http/api/prices_service.dart';
import 'package:darkoff/data/service/http/api/status_service.dart';
import 'package:darkoff/data/service/http/api/tasks_service.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/data/service/http/interceptors/in_memory_cache_interceptor.dart';
import 'package:darkoff/data/service/http/interceptors/request_log_interceptor.dart';
import 'package:darkoff/data/service/http/interceptors/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

Future<void> setupNetworkServiceLocator() async {
  getIt.registerLazySingleton<BaseOptions>(() {
    final baseUrl = AppConfig.apiBaseUrl;
    final normalized = baseUrl.endsWith('/') ? baseUrl : '$baseUrl/';

    return BaseOptions(
      baseUrl: normalized,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      responseType: ResponseType.json,
    );
  });
  // For using single Dio instance
  getIt.registerLazySingleton<RetryInterceptor>(
    () => RetryInterceptor(getIt<Logger>(), () => getIt<Dio>()),
  );
  getIt.registerLazySingleton<InMemoryCacheInterceptor>(
    () => InMemoryCacheInterceptor(),
  );
  getIt.registerLazySingleton<RequestLogInterceptor>(
    () => RequestLogInterceptor(getIt<Logger>()),
  );

  getIt.registerLazySingleton<Dio>(() {
    final service = Dio(getIt<BaseOptions>());
    service.interceptors.addAll([
      getIt<InMemoryCacheInterceptor>(),
      getIt<RetryInterceptor>(),
      if (AppConfig.isDevelopment) getIt<RequestLogInterceptor>(),
    ]);

    return service;
  });

  final dio = getIt<Dio>();
  getIt
    ..registerLazySingleton<ItemsService>(() => ItemsService(dio))
    ..registerLazySingleton<PricesService>(() => PricesService(dio))
    ..registerLazySingleton<TradersService>(() => TradersService(dio))
    ..registerLazySingleton<BartersService>(() => BartersService(dio))
    ..registerLazySingleton<CraftsService>(() => CraftsService(dio))
    ..registerLazySingleton<HideoutService>(() => HideoutService(dio))
    ..registerLazySingleton<TasksService>(() => TasksService(dio))
    ..registerLazySingleton<MapsService>(() => MapsService(dio))
    ..registerLazySingleton<StatusService>(() => StatusService(dio))
    ..registerLazySingleton<LocalizationService>(() => LocalizationService(dio));
}
