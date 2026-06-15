import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_filter_chip.dart';
import 'package:darkoff/core/widgets/app_search_bar.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/section_label.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/tasks/notifiers/tasks_notifier.dart';
import 'package:darkoff/presentation/features/tasks/notifiers/trader_filter_notifier.dart';
import 'package:darkoff/presentation/features/tasks/state/tasks_state.dart';
import 'package:darkoff/presentation/features/tasks/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final state = ref.watch(tasksProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: PageHeader(
                title: 'Tasks',
                subtitle: 'Trader quests & objectives',
                showBack: false,
              ),
            ),
            SliverToBoxAdapter(child: buildSearchBar(context)),
            SliverToBoxAdapter(child: buildTraderChips(context)),
            const SliverToBoxAdapter(
              child: SectionLabel('Tasks'),
            ),
            buildContent(context, state),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Hero(
      tag: 'tasks-search',
      child: AppSearchBar(
        controller: _searchController,
        onChanged: (_) {},
        hintText: 'Search tasks...',
        readOnlyMode: true,
        onTap: () => context.router.push(const TasksSearchRoute()),
      ),
    );
  }

  Widget buildContent(BuildContext context, TasksState state) {
    return state.when(
      initial: () => const SliverLoadingIndicator(),
      loading: () => const SliverLoadingIndicator(),
      empty: () => const SliverEmptyMessage(message: 'No tasks available'),
      loaded: (tasks) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => TaskCard(task: tasks[i]),
          childCount: tasks.length,
        ),
      ),
      error: (message) => SliverErrorMessage(
        message: 'Failed to load tasks',
        onRetry: () => ref.read(tasksProvider.notifier).refresh(),
      ),
    );
  }

  Widget buildTraderChips(BuildContext context) {
    final traderState = ref.watch(traderFilterProvider);

    return AppFilterChipRow(
      items: traderState.traders
          .map((item) => ChipItem(item.label))
          .toList(),
      selectedIndex: traderState.selectedIndex,
      onSelected: (int value) {
        setState(
              () => ref.read(traderFilterProvider.notifier).selectTrader(value),
        );
      },
    );
  }
}
