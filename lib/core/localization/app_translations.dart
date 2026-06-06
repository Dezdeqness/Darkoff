import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:i18n_extension/i18n_extension.dart';

class AppTranslations {
  AppTranslations._();

  static const defaultLocale = 'en-US';

  static const bundles = {
    'en-US': 'assets/i18n/en.json',
    'ru-RU': 'assets/i18n/ru.json',
  };

  static Translations? translations;

  static Future<void> load() async {
    final perLocale = <String, Map<String, String>>{};

    for (final entry in bundles.entries) {
      final raw = await rootBundle.loadString(entry.value);

      perLocale[entry.key] = (jsonDecode(raw) as Map<String, dynamic>)
          .map((k, v) => MapEntry(k, v.toString()));
    }

    final defaultTranslations =
        perLocale[defaultLocale] ?? const <String, String>{};

    final byId = <String, Map<String, String>>{};

    final allKeys = perLocale.values
        .expand((e) => e.keys)
        .toSet();

    for (final key in allKeys) {
      byId[key] = {
        for (final locale in bundles.keys)
          locale: perLocale[locale]?[key] ??
              defaultTranslations[key] ??
              key,
      };
    }

    translations = Translations.byId(
      defaultLocale,
      byId,
    );
  }
}

extension AppI18n on String {
  String get i18n {
    final t = AppTranslations.translations;

    if (t == null) {
      return this;
    }

    try {
      final translated = localize(this, t);

      return translated.isEmpty ? this : translated;
    } catch (_) {
      return this;
    }
  }
}