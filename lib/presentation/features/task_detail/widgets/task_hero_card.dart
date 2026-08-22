import 'package:darkoff/presentation/features/task_detail/model/task_detail_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TaskHeroCard extends StatelessWidget {
  const TaskHeroCard({super.key, required this.task});

  final TaskDetailUiModel task;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return AppCard.clipPadding(
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
                    child: Icon(
                      Icons.assignment_outlined,
                      color: colors.gold,
                      size: 40,
                    ),
                  ),
                ),
              ),
            )
          else
            Container(
              height: 80,
              color: colors.goldSubtle,
              child: Center(
                child: Icon(
                  Icons.assignment_outlined,
                  color: colors.gold,
                  size: 36,
                ),
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
                          horizontal: 5,
                          vertical: 2,
                        ),
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
                  children: task.meta
                      .map(
                        (m) =>
                            _MetaChip(icon: _metaIcon(m.kind), label: m.label),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

IconData _metaIcon(TaskMetaKind kind) {
  return switch (kind) {
    TaskMetaKind.level => Icons.person,
    TaskMetaKind.map => Icons.map_outlined,
    TaskMetaKind.experience => Icons.star_outline,
  };
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
