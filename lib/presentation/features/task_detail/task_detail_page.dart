import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/task_detail/model/task_detail_ui_model.dart';
import 'package:darkoff/presentation/features/task_detail/notifiers/task_detail_notifier.dart';
import 'package:darkoff/presentation/features/task_detail/state/task_detail_state.dart';
import 'package:darkoff/presentation/features/task_detail/widgets/task_detail_section.dart';
import 'package:darkoff/presentation/features/task_detail/widgets/task_hero_card.dart';
import 'package:darkoff/presentation/features/task_detail/widgets/task_objective_list.dart';
import 'package:darkoff/presentation/features/task_detail/widgets/task_prerequisite_list.dart';
import 'package:darkoff/presentation/features/task_detail/widgets/task_reward_list.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TaskDetailPage extends ConsumerWidget {
  const TaskDetailPage({super.key, @PathParam('taskId') required this.taskId});

  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(taskDetailProvider(taskId));

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: state.when(
          initial: () =>
              Center(child: CircularProgressIndicator(color: colors.gold)),
          loading: () =>
              Center(child: CircularProgressIndicator(color: colors.gold)),
          loaded: (task) => buildContent(context, task),
          error: (message) => AppErrorView(
            message: message,
            onRetry: () =>
                ref.read(taskDetailProvider(taskId).notifier).retry(),
          ),
        ),
      ),
    );
  }

  Widget buildContent(BuildContext context, TaskDetailUiModel task) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: PageHeader(title: task.name)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              TaskHeroCard(task: task),
              const SizedBox(height: 16),
              if (task.prerequisiteTaskNames.isNotEmpty) ...[
                TaskDetailSection(
                  title: tr.taskDetail.section.prerequisites,
                  child: TaskPrerequisiteList(
                    names: task.prerequisiteTaskNames,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (task.objectives.isNotEmpty) ...[
                TaskDetailSection(
                  title: tr.taskDetail.section.objectives,
                  child: TaskObjectiveList(objectives: task.objectives),
                ),
                const SizedBox(height: 12),
              ],
              if (task.rewardItems.isNotEmpty ||
                  task.rewardStanding.isNotEmpty ||
                  task.experienceLabel != null) ...[
                TaskDetailSection(
                  title: tr.taskDetail.section.rewards,
                  child: TaskRewardList(
                    experienceLabel: task.experienceLabel,
                    items: task.rewardItems,
                    standing: task.rewardStanding,
                  ),
                ),
              ],
              const SizedBox(height: 32),
            ]),
          ),
        ),
      ],
    );
  }
}
