import 'package:darkoff/core/config/app_config.dart';
import 'package:darkoff/service_locator/categories_service_locator.dart';
import 'package:darkoff/service_locator/graphql_service_locator.dart';

Future<void> setupServiceLocator() async {
  await AppConfig.initialize();
  
  setupCategoriesServiceLocator();
  await setupGraphQLServiceLocator();
}
