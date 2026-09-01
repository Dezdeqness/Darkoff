import 'dart:async';

import 'package:tasks_contract/tasks_contract.dart';
import 'package:darkoff/presentation/features/tasks/mapper/task_ui_mapper.dart';
import 'package:darkoff/presentation/features/tasks/state/tasks_search_state.dart';
import 'package:darkoff/service_locator/tasks_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tasks_search_notifier.g.dart';

@riverpod
class TasksSearchNotifier extends _$TasksSearchNotifier {
  late TasksRepository _repository;
  late TaskUiMapper _mapper;
  Timer? _debounce;

  String _lastQuery = '';

  @override
  TasksSearchState build() {
    _repository = getIt<TasksRepository>();
    _mapper = getIt<TaskUiMapper>();

    ref.onDispose(clear);

    return const TasksSearchState.initial();
  }

  void onQueryChanged(String query) {
    _lastQuery = query;
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      _search(query);
    });
  }

  Future<void> refresh() async {
    await _search(_lastQuery);
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) {
      state = const TasksSearchState.initial();
      return;
    }

    state = const TasksSearchState.loading();

    final result = await _repository.searchTasks(query: query);

    if (!ref.mounted) return;

    result.fold(
      (tasks) {
        if (tasks.isEmpty) {
          state = const TasksSearchState.empty();
        } else {
          state = TasksSearchState.loaded(_mapper.fromEntities(tasks));
        }
      },
      (error) {
        state = TasksSearchState.error(error.toString());
      },
    );
  }

  void clear() {
    _debounce?.cancel();
    _lastQuery = '';
  }
}
