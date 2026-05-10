import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:darkoff/core/widgets/app_filter_chip.dart';
import 'package:darkoff/core/widgets/app_search_bar.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/section_label.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/tasks/model/task_ui_model.dart';
import 'package:darkoff/presentation/features/tasks/notifiers/tasks_notifier.dart';
import 'package:darkoff/presentation/features/tasks/state/tasks_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _Trader {
  const _Trader(this.label, this.normalizedName);
  final String label;
  final String normalizedName;
}

// TODO(any): Make remote related
const _kTraders = <_Trader>[
  _Trader('All', ''),
  _Trader('Prapor', 'prapor'),
  _Trader('Therapist', 'therapist'),
  _Trader('Skier', 'skier'),
  _Trader('Peacekeeper', 'peacekeeper'),
  _Trader('Mechanic', 'mechanic'),
  _Trader('Ragman', 'ragman'),
  _Trader('Jaeger', 'jaeger'),
];

@RoutePage()
class TasksPage extends ConsumerStatefulWidget {
  const TasksPage({super.key});

  @override
  ConsumerState<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends ConsumerState<TasksPage> {
  int _selectedTraderIndex = 0;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<TaskUiModel> _filtered(List<TaskUiModel> tasks) {
    return tasks.where((t) {
      if (_selectedTraderIndex != 0 &&
          t.traderNormalizedName !=
              _kTraders[_selectedTraderIndex].normalizedName) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        return t.name.toLowerCase().contains(q) ||
            t.objectives
                .any((o) => o.description.toLowerCase().contains(q));
      }
      return true;
    }).toList();
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
            SliverToBoxAdapter(
              child: AppSearchBar(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                hintText: 'Search tasks...',
              ),
            ),
            SliverToBoxAdapter(child: _buildTraderChips(context)),
            const SliverToBoxAdapter(
              child: SectionLabel('Tasks'),
            ),
            ..._buildContent(context, state),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, TasksState state) {
    return switch (state) {
      TasksInitial() || TasksLoading() => [
          const SliverLoadingIndicator(),
        ],
      TasksEmpty() => [
          const SliverEmptyMessage(message: 'No tasks available'),
        ],
      TasksError() => [
          SliverErrorMessage(
            message: 'Failed to load tasks',
            onRetry: () => ref.read(tasksProvider.notifier).refresh(),
          ),
        ],
      TasksLoaded(:final tasks) => _buildTaskList(context, tasks),
      _ => [],
    };
  }

  List<Widget> _buildTaskList(BuildContext context, List<TaskUiModel> tasks) {
    final filtered = _filtered(tasks);
    if (filtered.isEmpty) {
      return [
        const SliverEmptyMessage(message: 'No tasks found'),
      ];
    }
    return [
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => _TaskCard(task: filtered[i]),
          childCount: filtered.length,
        ),
      ),
    ];
  }

  Widget _buildTraderChips(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        height: 43,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _kTraders.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            return AppFilterChip(
              label: _kTraders[i].label,
              isActive: i == _selectedTraderIndex,
              onTap: () => setState(() => _selectedTraderIndex = i),
            );
          },
        ),
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({required this.task});
  final TaskUiModel task;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    final firstObjective =
        task.objectives.isNotEmpty ? task.objectives.first.description : null;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: AppCard(
        onTap: () => context.router.push(TaskDetailRoute(taskId: task.id)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: colors.borderStrong, width: 1.5),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          task.name,
                          style: typo.labelLarge.copyWith(
                            color: colors.textPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (task.kappaRequired) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: colors.goldSubtle,
                            borderRadius: shape.radiusXS,
                          ),
                          child: Text(
                            'KAPPA',
                            style: typo.labelSmall.copyWith(
                              color: colors.gold,
                              fontSize: 8,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),

                  Text(
                    task.traderName,
                    style:
                        typo.paragraphSmall.copyWith(color: colors.gold),
                  ),
                  const SizedBox(height: 6),

                  if (firstObjective != null) ...[
                    Text(
                      firstObjective,
                      style: typo.paragraphSmall
                          .copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(height: 6),
                  ],

                  if (task.mapName != null)
                    Row(
                      children: [
                        Icon(Icons.map_outlined,
                            size: 10, color: colors.textTertiary),
                        const SizedBox(width: 3),
                        Text(
                          task.mapName!,
                          style: typo.paragraphSmall
                              .copyWith(color: colors.textTertiary),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
