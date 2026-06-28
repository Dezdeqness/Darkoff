import 'package:darkoff/data/mapper/status_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/server_status.graphql.dart';
import 'package:darkoff/domain/entities/server_status_entity.dart';
import 'package:darkoff/domain/repositories/server_status_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class ServerStatusRepositoryImpl implements ServerStatusRepository {
  const ServerStatusRepositoryImpl({
    required DarkoffQLService service,
    required StatusMapper mapper,
  })  : _service = service,
        _mapper = mapper;

  final DarkoffQLService _service;
  final StatusMapper _mapper;

  @override
  Future<Result<ServerStatusEntity>> getStatus() async {
    try {
      final result = await _service.getServerStatus();

      if (result.hasException) {
        return failureOf(Exception(result.exception.toString()));
      }

      final data = result.data;
      if (data == null) {
        return failureOf(Exception('Empty response'));
      }

      final parsed = Query$DarkoffServerStatus.fromJson(data);
      final entity = _mapper.fromGraphql(parsed.status);
      if (entity == null) {
        return failureOf(Exception('Could not parse status'));
      }

      return successOf(entity);
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
