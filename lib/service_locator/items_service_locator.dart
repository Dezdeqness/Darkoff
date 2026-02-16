import 'package:darkoff/data/mapper/item_mapper.dart';
import 'package:darkoff/data/repositories/items_repository_impl.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupItemsServiceLocator() {
  getIt.registerLazySingleton<ItemMapper>(() => ItemMapper());

  getIt.registerLazySingleton<ItemsRepository>(
    () => ItemsRepositoryImpl(
      service: getIt<DarkoffQLService>(),
      mapper: getIt<ItemMapper>(),
    ),
  );
}
