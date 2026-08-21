import 'package:darkoff/presentation/features/flea_market/model/flea_item_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class FleaItemRow extends StatelessWidget {
  const FleaItemRow({
    super.key,
    required this.item,
    required this.rank,
    this.onTap,
  });

  final FleaItemUiModel item;
  final int rank;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return AppCard(
      padding: const EdgeInsets.all(10),
      onTap: onTap,
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '$rank',
              style: typo.labelSmall.copyWith(
                color: colors.textTertiary,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 8),

          ItemIcon(
            imageUrl: item.iconLink,
            fallbackIcon: Icons.inventory_2_outlined,
            size: 40,
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.displayName,
                  style: typo.labelMedium.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.categoryName != null)
                  Text(
                    item.categoryName!,
                    style: typo.paragraphSmall
                        .copyWith(color: colors.textTertiary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item.displayPrice,
                style: typo.labelMedium.copyWith(
                  color: colors.gold,
                  fontWeight: FontWeight.w600,
                ),
              ),
              PercentChangeBadge(percent: item.changePercent),
            ],
          ),
        ],
      ),
    );
  }
}
