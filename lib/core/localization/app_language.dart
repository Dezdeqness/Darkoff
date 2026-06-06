import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:flutter/widgets.dart';

class AppLanguage {
  const AppLanguage._();

  static const List<Enum$LanguageCode> supported = [
    Enum$LanguageCode.en,
    Enum$LanguageCode.ru,
    Enum$LanguageCode.de,
    Enum$LanguageCode.fr,
    Enum$LanguageCode.es,
    Enum$LanguageCode.zh,
  ];

  static const Enum$LanguageCode fallback = Enum$LanguageCode.en;

  static const List<Locale> supportedUiLocales = [
    Locale('en'),
    Locale('ru'),
  ];

  static Locale toLocale(Enum$LanguageCode language) =>
      Locale(language.toJson());

  static Enum$LanguageCode resolve(String? code) {
    if (code == null) return fallback;
    final parsed = Enum$LanguageCode.fromJson(code);
    return supported.contains(parsed) ? parsed : fallback;
  }
}
