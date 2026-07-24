import 'package:darkoff/data/service/http/api/status_service.dart';
import 'package:darkoff/domain/entities/server_status_entity.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class ServerStatusDataSource {
  ServerStatusDataSource({required StatusService statusService})
    : _statusService = statusService;

  final StatusService _statusService;

  Future<Result<ServerStatusEntity>> getStatus() async {
    try {
      final general = (await _statusService.getStatus()).data.generalStatus;
      if (general == null) {
        return failureOf(Exception('Could not parse server status'));
      }
      return successOf(
        ServerStatusEntity(
          name: general.name ?? '',
          status: general.status ?? 0,
          statusCode: general.statusCode ?? '',
        ),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
