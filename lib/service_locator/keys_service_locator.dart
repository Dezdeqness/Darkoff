import 'package:darkoff/data/datasources/keys/keys_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/repositories/keys_repository_impl.dart';
import 'package:darkoff/domain/repositories/keys_repository.dart';
import 'package:darkoff/presentation/features/keys/mapper/keys_list_ui_mapper.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupKeysServiceLocator() {
  getIt.registerLazySingleton<KeysListUiMapper>(() => KeysListUiMapper());

  getIt.registerLazySingleton<KeysDataSource>(
    () => KeysDataSource(dao: getIt<ItemsDao>()),
  );

  getIt.registerLazySingleton<KeysRepository>(
    () => KeysRepositoryImpl(dataSource: getIt<KeysDataSource>()),
  );
}
