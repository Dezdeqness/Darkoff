import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  AppConfig() : _dotenv = DotEnv();

  final DotEnv _dotenv;

  Future<void> load({String fileName = '.env'}) =>
      _dotenv.load(fileName: fileName);

  String get environment => _dotenv.get('ENV', fallback: 'development');

  bool get isDevelopment => environment == 'development';

  bool get isProduction => environment == 'production';

  String getString(String key, {String? fallback}) =>
      _dotenv.get(key, fallback: fallback);

  String? maybeGetString(String key) => _dotenv.maybeGet(key);

  bool getBool(String key, {bool? fallback}) =>
      _dotenv.getBool(key, fallback: fallback);

  int getInt(String key, {int? fallback}) =>
      _dotenv.getInt(key, fallback: fallback);

  double getDouble(String key, {double? fallback}) =>
      _dotenv.getDouble(key, fallback: fallback);
}
