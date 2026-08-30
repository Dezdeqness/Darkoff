import 'package:app_config/app_config.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupConfigServiceLocator() async {
  final config = AppConfig();
  await config.load();
  getIt.registerSingleton<AppConfig>(config);
}
