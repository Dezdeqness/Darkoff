import 'package:darkoff/service_locator/boss_service_locator.dart';
import 'package:darkoff/service_locator/barters_service_locator.dart';
import 'package:darkoff/service_locator/ammo_service_locator.dart';
import 'package:darkoff/service_locator/crafts_service_locator.dart';
import 'package:darkoff/service_locator/keys_service_locator.dart';
import 'package:darkoff/service_locator/database_service_locator.dart';
import 'package:darkoff/service_locator/hideout_service_locator.dart';
import 'package:darkoff/service_locator/flea_service_locator.dart';
import 'package:darkoff/service_locator/localization_service_locator.dart';
import 'package:darkoff/service_locator/network_service_locator.dart';
import 'package:darkoff/service_locator/home_service_locator.dart';
import 'package:darkoff/service_locator/maps_service_locator.dart';
import 'package:darkoff/service_locator/items_service_locator.dart';
import 'package:darkoff/service_locator/preload_service_locator.dart';
import 'package:darkoff/service_locator/traders_service_locator.dart';
import 'package:get_it/get_it.dart';
import 'package:darkoff/service_locator/tasks_service_locator.dart';
import 'package:app_localization/app_localization.dart';
import 'package:darkoff/core/localization/app_language.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<Logger>(() => Logger(filter: ProductionFilter()));

  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<LanguageStore>(
    LanguageStore(prefs, resolver: AppLanguage.resolve),
  );

  await setupNetworkServiceLocator();

  setupDatabaseServiceLocator();
  setupItemsServiceLocator();
  setupAmmoServiceLocator();
  setupHideoutServiceLocator();
  setupFleaServiceLocator();
  setupTradersServiceLocator();
  setupHomeServiceLocator();
  setupMapsServiceLocator();
  setupBartersServiceLocator();
  setupCraftsServiceLocator();
  setupBossServiceLocator();
  setupKeysServiceLocator();
  setupPreloadServiceLocator();
  setupLocalizationServiceLocator();
  setupTasksServiceLocator();
}
