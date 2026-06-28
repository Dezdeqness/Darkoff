import 'package:darkoff/domain/entities/server_status_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class ServerStatusRepository {
  Future<Result<ServerStatusEntity>> getStatus();
}
