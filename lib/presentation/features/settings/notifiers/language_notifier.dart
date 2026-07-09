import 'package:darkoff/core/localization/language_store.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final languageNotifierProvider =
    NotifierProvider<LanguageNotifier, Enum$LanguageCode>(LanguageNotifier.new);

class LanguageNotifier extends Notifier<Enum$LanguageCode> {
  late LanguageStore _store;

  @override
  Enum$LanguageCode build() {
    _store = getIt<LanguageStore>();
    return _store.language;
  }

  Future<void> setLanguage(Enum$LanguageCode language) async {
    if (language == state) return;
    await _store.setLanguage(language);
    state = language;
  }
}
