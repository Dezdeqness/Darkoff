import 'package:darkoff/presentation/features/tasks/model/task_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tasks_search_state.freezed.dart';

@freezed
class TasksSearchState with _$TasksSearchState {
  const factory TasksSearchState.initial() = TasksSearchInitial;
  const factory TasksSearchState.loading() = TasksSearchLoading;
  const factory TasksSearchState.empty() = TasksSearchEmpty;
  const factory TasksSearchState.loaded(List<TaskUiModel> tasks) =
      TasksSearchLoaded;
  const factory TasksSearchState.error(String message) = TasksSearchError;
}
