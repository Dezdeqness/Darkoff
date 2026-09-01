import 'package:app_localization/app_localization.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/local/dao/reference_dao.dart';
import 'package:darkoff/data/local/dao/tasks_dao.dart';
import 'package:darkoff/data/mapper/trader_mapper.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/data/service/preload_service.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:tasks_contract/tasks_contract.dart';
import 'package:logger/logger.dart';

import 'barters_service_locator.dart';

void setupPreloadServiceLocator() {
  getIt.registerLazySingleton<PreloadService>(
        () => PreloadService(
      repository: getIt<ItemsRepository>(),
      dao: getIt<ItemsDao>(),
      tasksRepository: getIt<TasksRepository>(),
      tasksDao: getIt<TasksDao>(),
      referenceDao: getIt<ReferenceDao>(),
      tradersService: getIt<TradersService>(),
      traderMapper: getIt<TraderMapper>(),
      localization: getIt<LocalizationDataSource>(),
      languageStore: getIt<LanguageStore>(),
      logger: getIt<Logger>(),
    ),
  );
}
