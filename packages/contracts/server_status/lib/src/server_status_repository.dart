import 'package:result_dart/result_dart.dart';
import 'package:server_status_contract/src/server_status_entity.dart';

abstract interface class ServerStatusRepository {
  Future<Result<ServerStatusEntity>> getStatus();
}
