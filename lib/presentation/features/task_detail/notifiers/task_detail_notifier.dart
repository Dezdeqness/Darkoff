import 'package:tasks_contract/tasks_contract.dart';
import 'package:darkoff/presentation/features/task_detail/mapper/task_detail_ui_mapper.dart';
import 'package:darkoff/presentation/features/task_detail/state/task_detail_state.dart';
import 'package:darkoff/service_locator/tasks_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_detail_notifier.g.dart';

@riverpod
class TaskDetailNotifier extends _$TaskDetailNotifier {
  late final TasksRepository _repository;
  late final TaskDetailUiMapper _mapper;
  late final String _taskId;

  @override
  TaskDetailState build(String taskId) {
    _repository = getIt<TasksRepository>();
    _mapper = getIt<TaskDetailUiMapper>();
    _taskId = taskId;

    _loadDetail();
    return const TaskDetailState.loading();
  }

  Future<void> _loadDetail() async {
    state = const TaskDetailState.loading();

    final result = await _repository.getTask(_taskId);

    if (!ref.mounted) return;

    result.fold(
      (task) {
        state = TaskDetailState.loaded(_mapper.fromEntity(task));
      },
      (error) {
        state = TaskDetailState.error(error.toString());
      },
    );
  }

  void retry() {
    _loadDetail();
  }
}
