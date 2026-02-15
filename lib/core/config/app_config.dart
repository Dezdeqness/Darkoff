import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static late String _graphqlUrl;
  static late String _environment;

  static Future<void> initialize() async {
    await dotenv.load(fileName: '.env');
    _graphqlUrl = dotenv.env['TARKOV_GRAPHQL_URL'] ?? '';
    _environment = dotenv.env['ENV'] ?? 'development';
  }

  static String get graphqlUrl => _graphqlUrl;
  static String get environment => _environment;
  static bool get isDevelopment => _environment == 'development';
  static bool get isProduction => _environment == 'production';
}
