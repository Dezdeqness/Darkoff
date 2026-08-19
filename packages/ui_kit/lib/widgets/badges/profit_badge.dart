import 'package:ui_kit/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class ProfitBadge extends StatelessWidget {
  const ProfitBadge({
    super.key,
    required this.label,
    required this.isPositive,
  });

  final String label;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;
    final color = isPositive ? colors.profit : colors.loss;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: shape.radiusXS,
        border: Border.all(color: color.withAlpha(70)),
      ),
      child: RichText(
        text: TextSpan(
          text: label,
          style: typo.labelSmall.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class PercentChangeBadge extends StatelessWidget {
  const PercentChangeBadge({super.key, required this.percent});

  final double percent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;
    final isPositive = percent >= 0;
    final color = isPositive ? colors.profit : colors.loss;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: shape.radiusXS,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isPositive ? Icons.arrow_drop_up : Icons.arrow_drop_down,
            size: 12,
            color: color,
          ),
          RichText(
            text: TextSpan(
              text: '${percent.abs().toStringAsFixed(1)}%',
              style: typo.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
