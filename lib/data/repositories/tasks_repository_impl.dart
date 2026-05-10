import 'package:darkoff/data/mapper/task_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/tasks.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:darkoff/domain/repositories/tasks_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class TasksRepositoryImpl implements TasksRepository {
  const TasksRepositoryImpl({
    required DarkoffQLService service,
    required TaskMapper mapper,
  })  : _service = service,
        _mapper = mapper;

  final DarkoffQLService _service;
  final TaskMapper _mapper;

  @override
  Future<Result<List<TaskEntity>>> getTasks() async {
    try {
      final result = await _service.getTasks(
        gameMode: Enum$GameMode.pve,
      );

      if (result.hasException) {
        return failureOf(
          Exception(result.exception.toString()),
        );
      }

      final data = result.data;

      if (data == null) {
        return failureOf(
          Exception('Empty response'),
        );
      }

      final parsed = Query$DarkoffTasks.fromJson(data);

      return successOf(
        parsed.tasks
            .whereType<Query$DarkoffTasks$tasks>()
            .map((t) => _mapper.fromGraphql(t))
            .toList(),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
