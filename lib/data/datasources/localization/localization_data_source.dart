import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/core/localization/language_store.dart';
import 'package:darkoff/data/service/http/api/localization_service.dart';
import 'package:dio/dio.dart';

class LocalizationDataSource {
  const LocalizationDataSource(this._api, this._languageStore);

  final LocalizationService _api;
  final LanguageStore _languageStore;

  Future<Map<String, String>> localize(GameMode mode, String name) async {
    try {
      final response = await _api.getLocale(
        mode.apiValue,
        name,
        _languageStore.language.code,
      );
      return response.data.map(
        (key, value) => MapEntry(key, value?.toString() ?? ''),
      );
    } on DioException {
      return const {};
    }
  }
}
