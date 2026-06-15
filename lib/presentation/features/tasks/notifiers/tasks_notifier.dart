import 'package:darkoff/domain/repositories/tasks_repository.dart';
import 'package:darkoff/presentation/features/tasks/mapper/task_ui_mapper.dart';
import 'package:darkoff/presentation/features/tasks/notifiers/trader_filter_notifier.dart';
import 'package:darkoff/presentation/features/tasks/state/tasks_state.dart';
import 'package:darkoff/service_locator/tasks_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_notifier.g.dart';

@riverpod
class TasksNotifier extends _$TasksNotifier {
  late TasksRepository _repository;
  late TaskUiMapper _mapper;
  String _selectedTrader = '';

  @override
  TasksState build() {
    _repository = getIt<TasksRepository>();
    _mapper = getIt<TaskUiMapper>();

    final traderState = ref.watch(traderFilterProvider);
    _selectedTrader =
        traderState.traders[traderState.selectedIndex].normalizedName;

    loadTasks();
    return const TasksState.initial();
  }

  Future<void> loadTasks({bool isRefresh = false}) async {
    if (isRefresh) {
      state = const TasksState.loading();
    }

    try {
      final result = await _repository.getTasks(
        traderNormalizedName: _selectedTrader,
        forceRefresh: isRefresh,
      );

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
    await loadTasks(isRefresh: true);
  }
}
