import 'package:darkoff/domain/repositories/tasks_repository.dart';
import 'package:darkoff/presentation/features/tasks/mapper/task_ui_mapper.dart';
import 'package:darkoff/presentation/features/tasks/state/tasks_state.dart';
import 'package:darkoff/service_locator/tasks_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_notifier.g.dart';

@riverpod
class TasksNotifier extends _$TasksNotifier {
  late TasksRepository _repository;
  late TaskUiMapper _mapper;

  @override
  TasksState build() {
    _repository = getIt<TasksRepository>();
    _mapper = getIt<TaskUiMapper>();
    loadTasks();
    return const TasksState.initial();
  }

  Future<void> loadTasks() async {
    state = const TasksState.loading();

    try {
      final result = await _repository.getTasks();

      result.fold(
        (tasks) {
          if (tasks.isEmpty) {
            state = const TasksState.empty();
          } else {
            state = TasksState.loaded(_mapper.fromEntities(tasks));
          }
        },
        (error) {
          state = TasksState.error(error.toString());
        },
      );
    } catch (e) {
      state = TasksState.error(e.toString());
    }
  }

  Future<void> refresh() async {
    await loadTasks();
  }
}
