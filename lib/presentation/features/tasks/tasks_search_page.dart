import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_search_bar.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/tasks/notifiers/tasks_search_notifier.dart';
import 'package:darkoff/presentation/features/tasks/state/tasks_search_state.dart';
import 'package:darkoff/presentation/features/tasks/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TasksSearchPage extends ConsumerStatefulWidget {
  const TasksSearchPage({super.key});

  @override
  ConsumerState<TasksSearchPage> createState() => _TasksSearchPageState();
}

class _TasksSearchPageState extends ConsumerState<TasksSearchPage> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(tasksSearchProvider);
    final colors = context.colorTheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Hero(
                tag: 'tasks-search',
                child: AppSearchBar(
                  hintText: 'Search tasks...',
                  controller: _textController,
                  autofocus: true,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  onChanged: (query) {
                    ref
                        .read(tasksSearchProvider.notifier)
                        .onQueryChanged(query);
                  },
                ),
              ),
            ),
            buildContent(context, state),
          ],
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, TasksSearchState state) {
    return state.when(
      initial: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
      loading: () => const SliverLoadingIndicator(),
      empty: () => const SliverEmptyMessage(message: 'No tasks found'),
      loaded: (tasks) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => TaskCard(task: tasks[i]),
          childCount: tasks.length,
        ),
      ),
      error: (message) => SliverErrorMessage(
        message: 'Failed to search tasks',
        onRetry: () => ref.read(tasksSearchProvider.notifier).refresh(),
      ),
    );
  }
}
