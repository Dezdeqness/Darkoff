import 'package:app_localization/app_localization.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:flutter/widgets.dart';

class AppLanguage {
  const AppLanguage._();

  static const List<LanguageCode> supported = [
    LanguageCode.en,
    LanguageCode.ru,
    LanguageCode.de,
    LanguageCode.fr,
    LanguageCode.es,
    LanguageCode.zh,
  ];

  static const LanguageCode fallback = LanguageCode.en;

  static const List<Locale> supportedUiLocales = [
    Locale('en'),
    Locale('ru'),
  ];

  static Locale toLocale(LanguageCode language) => Locale(language.code);

  static AppLocale toSlangLocale(LanguageCode language) => switch (language) {
        LanguageCode.ru => AppLocale.ru,
        _ => AppLocale.en,
      };

  static LanguageCode resolve(String? code) {
    final parsed = LanguageCode.tryParse(code);
    return (parsed != null && supported.contains(parsed)) ? parsed : fallback;
  }
}
