import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/home/model/price_change_ui_model.dart';
import 'package:darkoff/presentation/features/home/widgets/trend_color.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class PriceChangeRow extends StatelessWidget {
  const PriceChangeRow({
    super.key,
    required this.item,
    required this.isLast,
  });

  final PriceChangeUiModel item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return InkWell(
      onTap: () => context.router.push(ItemDetailRoute(itemId: item.id)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: isLast
            ? null
            : BoxDecoration(
                border: Border(bottom: BorderSide(color: colors.border)),
              ),
        child: Row(
          children: [
            ItemIcon(
              imageUrl: item.iconUrl,
              fallbackIcon: Icons.inventory_2_outlined,
              size: 32,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                style: typo.bodyMedium.copyWith(color: colors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: item.trend.subtleColor(colors),
                borderRadius: shape.radiusXS,
              ),
              child: Text(
                item.changeLabel,
                style: typo.labelSmall.copyWith(
                  color: item.trend.color(colors),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
