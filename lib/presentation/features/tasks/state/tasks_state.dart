import 'package:darkoff/presentation/features/tasks/model/task_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks_state.freezed.dart';

@freezed
class TasksState with _$TasksState {
  const factory TasksState.initial() = TasksInitial;
  const factory TasksState.loading() = TasksLoading;
  const factory TasksState.empty() = TasksEmpty;
  const factory TasksState.loaded(List<TaskUiModel> tasks) = TasksLoaded;
  const factory TasksState.error(String message) = TasksError;
}
