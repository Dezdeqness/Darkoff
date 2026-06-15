import 'package:darkoff/presentation/features/task_detail/model/task_detail_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_detail_state.freezed.dart';

@freezed
class TaskDetailState with _$TaskDetailState {
  const factory TaskDetailState.initial() = TaskDetailInitial;
  const factory TaskDetailState.loading() = TaskDetailLoading;
  const factory TaskDetailState.loaded(TaskDetailUiModel task) =
      TaskDetailLoaded;
  const factory TaskDetailState.error(String message) = TaskDetailError;
}
