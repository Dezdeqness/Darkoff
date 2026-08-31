import 'package:result_dart/result_dart.dart';
import 'package:tasks_contract/src/task_entity.dart';

abstract interface class TasksRepository {
  Future<Result<List<TaskEntity>>> getRemoteTasks();

  Future<Result<List<TaskEntity>>> getTasks({
    String traderNormalizedName = '',
  });

  Future<Result<List<TaskEntity>>> searchTasks({String query = ''});

  Future<Result<TaskEntity>> getTask(String id);
}
