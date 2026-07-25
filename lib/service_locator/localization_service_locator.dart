import 'package:darkoff/core/localization/language_store.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/service/http/api/localization_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupLocalizationServiceLocator() {
  getIt.registerLazySingleton<LocalizationDataSource>(
    () => LocalizationDataSource(
      getIt<LocalizationService>(),
      getIt<LanguageStore>(),
    ),
  );
}
