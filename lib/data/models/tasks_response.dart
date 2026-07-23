import 'package:darkoff/data/models/task_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tasks_response.g.dart';

@JsonSerializable(createToJson: false)
class TasksResponse {
  const TasksResponse({this.data = const TasksData()});

  factory TasksResponse.fromJson(Map<String, dynamic> json) =>
      _$TasksResponseFromJson(json);

  final TasksData data;
}

@JsonSerializable(createToJson: false)
class TasksData {
  const TasksData({this.tasks = const {}});

  factory TasksData.fromJson(Map<String, dynamic> json) =>
      _$TasksDataFromJson(json);

  final Map<String, TaskApi> tasks;
}
