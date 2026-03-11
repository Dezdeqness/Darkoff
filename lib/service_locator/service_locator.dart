import 'package:darkoff/core/config/app_config.dart';
import 'package:darkoff/service_locator/categories_service_locator.dart';
import 'package:darkoff/service_locator/database_service_locator.dart'
    show setupDatabaseServiceLocator, setupPreloadServiceLocator;
import 'package:darkoff/service_locator/graphql_service_locator.dart';
import 'package:darkoff/service_locator/items_service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  await AppConfig.initialize();

  getIt.registerLazySingleton<Logger>(() => Logger());

  await setupGraphQLServiceLocator();

  setupDatabaseServiceLocator();
  setupCategoriesServiceLocator();
  setupItemsServiceLocator();
  setupPreloadServiceLocator();
}
