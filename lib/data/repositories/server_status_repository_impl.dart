import 'package:darkoff/data/datasources/server_status/server_status_data_source.dart';
import 'package:server_status_contract/server_status_contract.dart';
import 'package:result_dart/result_dart.dart';

class ServerStatusRepositoryImpl implements ServerStatusRepository {
  const ServerStatusRepositoryImpl({required ServerStatusDataSource dataSource})
    : _dataSource = dataSource;

  final ServerStatusDataSource _dataSource;

  @override
  Future<Result<ServerStatusEntity>> getStatus() => _dataSource.getStatus();
}
