import 'package:darkoff/data/models/tasks_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'tasks_service.g.dart';

@RestApi()
abstract class TasksService {
  factory TasksService(Dio dio, {String baseUrl}) = _TasksService;

  @GET('{mode}/tasks')
  Future<TasksResponse> getTasks(@Path('mode') String mode);
}
