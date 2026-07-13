import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/dashed_border_painter.dart';
import 'package:darkoff/presentation/features/hideout/model/hideout_list_ui_model.dart';
import 'package:flutter/material.dart';

class ShoppingEntryCard extends StatelessWidget {
  const ShoppingEntryCard({super.key, required this.model, this.onTap});

  final ShoppingEntryUiModel model;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: GestureDetector(
        onTap: model.enabled ? onTap : null,
        behavior: HitTestBehavior.opaque,
        child: CustomPaint(
          painter: DashedBorderPainter(
            color: colors.gold.withValues(alpha: 0.5),
            radius: shape.radiusMD.topLeft.x,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: colors.goldSubtle,
              borderRadius: shape.radiusMD,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(Icons.shopping_cart_outlined,
                    color: colors.gold, size: 22),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SHOPPING LIST',
                        style: typo.labelSmall.copyWith(
                          color: colors.gold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        model.title,
                        style: typo.labelMedium
                            .copyWith(color: colors.textPrimary),
                      ),
                      const SizedBox(height: 1),
                      Text(
                        model.subtitle,
                        style: typo.paragraphSmall
                            .copyWith(color: colors.textSecondary),
                      ),
                    ],
                  ),
                ),
                if (model.enabled)
                  Icon(Icons.chevron_right, color: colors.gold, size: 18),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
