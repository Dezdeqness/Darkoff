import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:darkoff/core/widgets/item_icon.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/tasks/model/task_ui_model.dart';
import 'package:darkoff/presentation/features/tasks/notifiers/tasks_notifier.dart';
import 'package:darkoff/presentation/features/tasks/state/tasks_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TaskDetailPage extends ConsumerWidget {
  const TaskDetailPage({
    super.key,
    @PathParam('taskId') required this.taskId,
  });

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(tasksProvider);

    TaskUiModel? task;
    if (state is TasksLoaded) {
      try {
        task = state.tasks.firstWhere((t) => t.id == taskId);
      } catch (_) {}
    }

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PageHeader(title: task?.name ?? 'Task'),
            ),
            if (state is TasksLoading || state is TasksInitial)
              const SliverLoadingIndicator()
            else if (task != null)
              ..._buildContent(context, task)
            else
              const SliverEmptyMessage(message: 'Task not found'),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, TaskUiModel task) {
    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        sliver: SliverList(
          delegate: SliverChildListDelegate([
            _TaskHeroCard(task: task),
            const SizedBox(height: 16),
            if (task.prerequisiteTaskNames.isNotEmpty) ...[
              _TaskDetailSection(
                title: 'PREREQUISITES',
                child: _PrerequisiteList(names: task.prerequisiteTaskNames),
              ),
              const SizedBox(height: 12),
            ],
            if (task.objectives.isNotEmpty) ...[
              _TaskDetailSection(
                title: 'OBJECTIVES',
                child: _ObjectiveList(objectives: task.objectives),
              ),
              const SizedBox(height: 12),
            ],
            if (task.rewardItems.isNotEmpty ||
                task.rewardStanding.isNotEmpty ||
                task.experience > 0) ...[
              _TaskDetailSection(
                title: 'COMPLETION REWARDS',
                child: _RewardList(
                  experience: task.experience,
                  items: task.rewardItems,
                  standing: task.rewardStanding,
                ),
              ),
            ],
          ]),
        ),
      ),
    ];
  }
}

class _TaskHeroCard extends StatelessWidget {
  const _TaskHeroCard({required this.task});
  final TaskUiModel task;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return AppCard(
      clipContent: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (task.taskImageLink != null)
            AspectRatio(
              aspectRatio: 16 / 7,
              child: Image.network(
                task.taskImageLink!,
                fit: BoxFit.cover,
                errorBuilder: (ctx, e, st) => Container(
                  color: colors.goldSubtle,
                  child: Center(
                    child: Icon(Icons.assignment_outlined,
                        color: colors.gold, size: 40),
                  ),
                ),
              ),
            )
          else
            Container(
              height: 80,
              color: colors.goldSubtle,
              child: Center(
                child: Icon(Icons.assignment_outlined,
                    color: colors.gold, size: 36),
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ItemIcon(
                      imageUrl: task.traderImageLink,
                      fallbackIcon: Icons.person_outline,
                      size: 32,
                      useGoldBackground: false,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      task.traderName,
                      style: typo.labelMedium.copyWith(color: colors.gold),
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
                            fontSize: 9,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 10),

                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    if (task.minPlayerLevel != null)
                      _MetaChip(
                        icon: Icons.person,
                        label: 'Level ${task.minPlayerLevel}+',
                      ),
                    if (task.mapName != null)
                      _MetaChip(
                        icon: Icons.map_outlined,
                        label: task.mapName!,
                      ),
                    _MetaChip(
                      icon: Icons.star_outline,
                      label: '${task.experience} XP',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTheme;
    final typo = context.typographyTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: c.background,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11, color: c.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: typo.paragraphSmall.copyWith(color: c.textSecondary),
          ),
        ],
      ),
    );
  }
}

class _TaskDetailSection extends StatelessWidget {
  const _TaskDetailSection({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return AppCard(
      clipContent: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.goldSubtle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(shape.radiusMD.topLeft.x),
                topRight: Radius.circular(shape.radiusMD.topRight.x),
              ),
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(
              title,
              style: typo.labelSmall.copyWith(
                color: colors.gold,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _PrerequisiteList extends StatelessWidget {
  const _PrerequisiteList({required this.names});
  final List<String> names;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    return Column(
      children: names
          .map(
            (name) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Icon(Icons.check_box_outline_blank_rounded,
                      size: 14, color: colors.textSecondary),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: typo.paragraphSmall
                          .copyWith(color: colors.textSecondary),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

class _ObjectiveList extends StatelessWidget {
  const _ObjectiveList({required this.objectives});
  final List<TaskObjectiveUiModel> objectives;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: objectives.map((o) => _ObjectiveRow(objective: o)).toList(),
    );
  }
}

class _ObjectiveRow extends StatelessWidget {
  const _ObjectiveRow({required this.objective});
  final TaskObjectiveUiModel objective;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                border:
                    Border.all(color: colors.borderStrong, width: 1.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  objective.description,
                  style: typo.paragraphSmall
                      .copyWith(color: colors.textPrimary),
                ),
                if (objective.optional)
                  Text(
                    'Optional',
                    style: typo.paragraphSmall
                        .copyWith(color: colors.textTertiary),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RewardList extends StatelessWidget {
  const _RewardList({
    required this.experience,
    required this.items,
    required this.standing,
  });
  final int experience;
  final List<TaskRewardItemUiModel> items;
  final List<TaskRewardStandingUiModel> standing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (experience > 0)
          _RewardRow(
            icon: Icons.star_outline,
            label: '$experience EXP',
            iconColor: context.colorTheme.gold,
          ),

        ...standing.map(
          (s) => _RewardRow(
            icon: Icons.person_outline,
            label:
                '${s.traderName}: ${s.standing > 0 ? '+' : ''}${s.standing.toStringAsFixed(2)} reputation',
            iconColor: context.colorTheme.profit,
          ),
        ),

        ...items.map((r) => _RewardItemRow(item: r)),
      ],
    );
  }
}

class _RewardRow extends StatelessWidget {
  const _RewardRow({
    required this.icon,
    required this.label,
    required this.iconColor,
  });
  final IconData icon;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: typo.paragraphSmall.copyWith(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _RewardItemRow extends StatelessWidget {
  const _RewardItemRow({required this.item});
  final TaskRewardItemUiModel item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ItemIcon(
            imageUrl: item.iconLink,
            fallbackIcon: Icons.inventory_2_outlined,
            size: 36,
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.shortName,
                  style:
                      typo.labelMedium.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.price != null)
                  Text(
                    '${formatPrice(item.price!)} ₽ each',
                    style: typo.paragraphSmall
                        .copyWith(color: colors.textTertiary),
                  ),
              ],
            ),
          ),

          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              '× ${item.count}',
              style: typo.labelMedium.copyWith(
                color: colors.gold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
