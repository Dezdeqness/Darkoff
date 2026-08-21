import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/hideout_detail/model/hideout_detail_ui_model.dart';
import 'package:darkoff/presentation/features/hideout_detail/widgets/level_badge.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class LevelCardHeader extends StatelessWidget {
  const LevelCardHeader({
    super.key,
    required this.model,
    required this.expanded,
    required this.onToggle,
  });

  final LevelCardUiModel model;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    final headerColor = switch (model.status) {
      HideoutLevelStatus.built => colors.profitSubtle,
      HideoutLevelStatus.nextUp => colors.goldSubtle,
      HideoutLevelStatus.locked => colors.surfaceHigh,
    };
    final titleColor = switch (model.status) {
      HideoutLevelStatus.built => colors.profit,
      HideoutLevelStatus.nextUp => colors.gold,
      HideoutLevelStatus.locked => colors.textSecondary,
    };

    return GestureDetector(
      onTap: onToggle,
      behavior: HitTestBehavior.opaque,
      child: Container(
        color: headerColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Text(
              model.title,
              style: typo.labelLarge.copyWith(
                color: titleColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 8),
            switch (model.status) {
              HideoutLevelStatus.built => LevelBadge(
                  icon: Icons.check,
                  label: tr.hideoutDetail.badge.built,
                  color: colors.profit,
                  background: colors.profitSubtle,
                ),
              HideoutLevelStatus.nextUp => LevelBadge(
                  icon: Icons.bolt,
                  label: tr.hideoutDetail.badge.nextUp,
                  color: colors.profit,
                  background: colors.profitSubtle,
                ),
              HideoutLevelStatus.locked => LevelBadge(
                  icon: Icons.lock_outline,
                  label: tr.hideoutDetail.badge.locked,
                  color: colors.textSecondary,
                  background: colors.surfaceHigh,
                ),
            },
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (model.timeText != null) ...[
                    Icon(Icons.timer_outlined,
                        size: 12, color: colors.textSecondary),
                    const SizedBox(width: 4),
                    Text(
                      model.timeText!,
                      style: typo.paragraphSmall
                          .copyWith(color: colors.textSecondary),
                    ),
                    const SizedBox(width: 10),
                  ],
                  if (model.costText != null)
                    Flexible(
                      child: Text(
                        model.costText!,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: typo.labelMedium.copyWith(
                          color: colors.gold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (model.collapsedSummaryText != null)
                    Flexible(
                      child: Text(
                        model.collapsedSummaryText!,
                        textAlign: TextAlign.end,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: typo.paragraphSmall.copyWith(
                          color: colors.textTertiary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            AnimatedRotation(
              turns: expanded ? 0 : -0.25,
              duration: const Duration(milliseconds: 150),
              child: Icon(Icons.expand_more,
                  size: 16, color: colors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
