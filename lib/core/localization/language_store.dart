import 'package:darkoff/core/localization/app_language.dart';
import 'package:darkoff/core/localization/language_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageStore {
  LanguageStore(this._prefs);

  final SharedPreferences _prefs;

  static const _key = 'app_language';

  LanguageCode get language => AppLanguage.resolve(_prefs.getString(_key));

  Future<void> setLanguage(LanguageCode language) =>
      _prefs.setString(_key, language.code);
}
