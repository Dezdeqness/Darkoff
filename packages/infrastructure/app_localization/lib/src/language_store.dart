import 'package:app_localization/src/language_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef LanguageResolver = LanguageCode Function(String? code);

class LanguageStore {
  LanguageStore(this._prefs, {required LanguageResolver resolver})
      : _resolve = resolver;

  final SharedPreferences _prefs;
  final LanguageResolver _resolve;

  static const _key = 'app_language';
  static const _dataKey = 'data_language';

  LanguageCode get language => _resolve(_prefs.getString(_key));

  Future<void> setLanguage(LanguageCode language) =>
      _prefs.setString(_key, language.code);

  LanguageCode? get dataLanguage =>
      LanguageCode.tryParse(_prefs.getString(_dataKey));

  Future<void> setDataLanguage(LanguageCode language) =>
      _prefs.setString(_dataKey, language.code);
}
