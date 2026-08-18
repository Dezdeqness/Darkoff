import 'package:ui_kit/theme/extension/theme_extensions.dart';
import 'package:ui_kit/utils/price_utils.dart';
import 'package:flutter/material.dart';

class ProfitBadge extends StatelessWidget {
  const ProfitBadge({
    super.key,
    required this.value,
    this.showSign = true,
  });

  final int value;

  final bool showSign;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;
    final isPositive = value >= 0;
    final color = isPositive ? colors.profit : colors.loss;
    final sign = showSign && isPositive ? '+' : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: shape.radiusXS,
        border: Border.all(color: color.withAlpha(70)),
      ),
      child: Text(
        '$sign${formatPrice(value)} ₽',
        style: typo.labelSmall.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
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
          Text(
            '${percent.abs().toStringAsFixed(1)}%',
            style: typo.labelSmall.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
