import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class TasksRepository {
  Future<Result<List<TaskEntity>>> getRemoteTasks();

  Future<Result<List<TaskEntity>>> getTasks({
    String traderNormalizedName = '',
  });

  Future<Result<List<TaskEntity>>> searchTasks({String query = ''});

  Future<Result<TaskEntity>> getTask(String id);
}
