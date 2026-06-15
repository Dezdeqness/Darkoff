import 'package:darkoff/data/local/dao/tasks_dao.dart';
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
    required TasksDao dao,
  })  : _service = service,
        _mapper = mapper,
        _dao = dao;

  final DarkoffQLService _service;
  final TaskMapper _mapper;
  final TasksDao _dao;

  @override
  Future<Result<List<TaskEntity>>> getRemoteTasks() async {
    try {
      final result = await _service.getTasks(
        gameMode: Enum$GameMode.pve,
      );

      if (result.hasException) {
        return failureOf(Exception(result.exception.toString()));
      }

      final data = result.data;
      if (data == null) {
        return failureOf(Exception('Empty response'));
      }

      return successOf(
        Query$DarkoffTasks.fromJson(data)
            .tasks
            .whereType<Query$DarkoffTasks$tasks>()
            .map((t) => _mapper.fromGraphql(t))
            .toList(),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<TaskEntity>>> getTasks({
    String traderNormalizedName = '',
  }) async {
    try {
      final tasks = await _dao.getTasksByTrader(traderNormalizedName);
      return successOf(tasks);
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<TaskEntity>>> searchTasks({String query = ''}) async {
    try {
      final tasks = await _dao.searchTasks(query: query);
      return successOf(tasks);
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  @override
  Future<Result<TaskEntity>> getTask(String id) async {
    try {
      final task = await _dao.getTaskById(id);
      if (task == null) {
        return failureOf(Exception('Task not found'));
      }
      return successOf(task);
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
