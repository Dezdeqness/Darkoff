import 'package:darkoff/data/datasources/tasks/tasks_data_source.dart';
import 'package:darkoff/data/local/dao/tasks_dao.dart';
import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:darkoff/domain/repositories/tasks_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class TasksRepositoryImpl implements TasksRepository {
  const TasksRepositoryImpl({
    required TasksDataSource dataSource,
    required TasksDao dao,
  }) : _dataSource = dataSource,
       _dao = dao;

  final TasksDataSource _dataSource;
  final TasksDao _dao;

  @override
  Future<Result<List<TaskEntity>>> getRemoteTasks() =>
      _dataSource.getRemoteTasks();

  @override
  Future<Result<List<TaskEntity>>> getTasks({
    String traderNormalizedName = '',
  }) async {
    try {
      return successOf(await _dao.getTasksByTrader(traderNormalizedName));
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<TaskEntity>>> searchTasks({String query = ''}) async {
    try {
      return successOf(await _dao.searchTasks(query: query));
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  @override
  Future<Result<TaskEntity>> getTask(String id) async {
    try {
      final task = await _dao.getTaskById(id);
      if (task == null) return failureOf(Exception('Task not found'));
      return successOf(task);
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
