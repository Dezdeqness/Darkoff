import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:darkoff/presentation/features/tasks/model/task_ui_model.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

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
