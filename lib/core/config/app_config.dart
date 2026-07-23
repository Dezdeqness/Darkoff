import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late String _environment;
  static late String _imagesBaseUrl;
  static late String _apiBaseUrl;

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
    _environment = dotenv.env['ENV'] ?? 'development';
    _imagesBaseUrl = dotenv.env['TARKOV_IMAGES_BASE_URL'] ?? '';
    _apiBaseUrl =
        dotenv.env['TARKOV_JSON_URL'] ?? 'https://json.tarkov.dev';
  }

  static String get environment => _environment;
  static String get imagesBaseUrl => _imagesBaseUrl;
  static String get apiBaseUrl => _apiBaseUrl;
  static bool get isDevelopment => _environment == 'development';
  static bool get isProduction => _environment == 'production';
}
