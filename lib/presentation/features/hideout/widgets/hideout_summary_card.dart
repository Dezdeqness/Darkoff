import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/hideout/model/hideout_list_ui_model.dart';
import 'package:flutter/material.dart';

class HideoutSummaryCard extends StatelessWidget {
  const HideoutSummaryCard({super.key, required this.model});

  final HideoutSummaryUiModel model;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Container(
        decoration: BoxDecoration(
          color: colors.goldSubtle,
          border: colors.activeChipBorder,
          borderRadius: shape.radiusMD,
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.home_work_outlined, color: colors.gold, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: typo.labelMedium.copyWith(color: colors.gold),
                  ),
                  Text(
                    model.subtitle,
                    style: typo.paragraphSmall
                        .copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            if (model.displayCost != null)
              Text(
                model.displayCost!,
                style: typo.labelLarge.copyWith(
                  color: colors.gold,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
