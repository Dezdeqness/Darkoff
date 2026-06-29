import 'package:darkoff/core/config/app_config.dart';
import 'package:darkoff/service_locator/categories_service_locator.dart';
import 'package:darkoff/service_locator/database_service_locator.dart'
    show setupDatabaseServiceLocator, setupPreloadServiceLocator;
import 'package:darkoff/service_locator/graphql_service_locator.dart';
import 'package:darkoff/service_locator/home_service_locator.dart';
import 'package:darkoff/service_locator/items_service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:darkoff/service_locator/tasks_service_locator.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<Logger>(() => Logger(filter: ProductionFilter()));

  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<LanguageStore>(LanguageStore(prefs));

  await setupGraphQLServiceLocator();

  setupDatabaseServiceLocator();
  setupCategoriesServiceLocator();
  setupItemsServiceLocator();
  setupHomeServiceLocator();

  setupPreloadServiceLocator();
  setupTasksServiceLocator();

}
