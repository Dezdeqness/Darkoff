import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/item_icon.dart';
import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:flutter/material.dart';

class TraderItemThumb extends StatelessWidget {
  const TraderItemThumb({super.key, required this.item, required this.onTap});

  final TradeItemUiModel item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;
    final count = item.count;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 52,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ItemIcon(
                  imageUrl: item.iconLink,
                  fallbackIcon: Icons.inventory_2_outlined,
                  size: 46,
                ),
                if (count > 1)
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 1),
                      decoration: BoxDecoration(
                        color: colors.goldSubtle,
                        borderRadius: shape.radiusXS,
                        border: Border.all(color: colors.background, width: 1),
                      ),
                      child: Text(
                        '×$count',
                        style: typo.labelSmall.copyWith(color: colors.gold),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 3),
            Text(
              item.shortName,
              style: typo.labelSmall.copyWith(color: colors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
