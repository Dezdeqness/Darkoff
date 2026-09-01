import 'package:darkoff/data/datasources/keys/keys_data_source.dart';
import 'package:keys_contract/keys_contract.dart';
import 'package:result_dart/result_dart.dart';

class KeysRepositoryImpl implements KeysRepository {
  const KeysRepositoryImpl({required KeysDataSource dataSource})
    : _dataSource = dataSource;

  final KeysDataSource _dataSource;

  @override
  Future<Result<List<KeyEntity>>> getKeys() => _dataSource.getKeys();
}
