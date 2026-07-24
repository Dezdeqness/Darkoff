import 'package:darkoff/core/localization/language_code.dart';
import 'package:darkoff/core/localization/language_store.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageNotifierProvider =
    NotifierProvider<LanguageNotifier, LanguageCode>(LanguageNotifier.new);

class LanguageNotifier extends Notifier<LanguageCode> {
  late LanguageStore _store;

  @override
  LanguageCode build() {
    _store = getIt<LanguageStore>();
    return _store.language;
  }

  Future<void> setLanguage(LanguageCode language) async {
    if (language == state) return;
    await _store.setLanguage(language);
    state = language;
  }
}
