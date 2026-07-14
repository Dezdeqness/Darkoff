import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:darkoff/core/widgets/item_icon.dart';
import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:flutter/material.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer, required this.onTap});

  final TraderOfferUiModel offer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return AppCard(
      padding: const EdgeInsets.all(10),
      onTap: onTap,
      child: Row(
        children: [
          ItemIcon(
            imageUrl: offer.iconLink,
            fallbackIcon: Icons.inventory_2_outlined,
            size: 44,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              offer.itemName,
              style: typo.labelMedium.copyWith(color: colors.textPrimary),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (offer.priceText != null)
                Text(
                  offer.priceText!,
                  style: typo.labelMedium.copyWith(
                    color: colors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              const SizedBox(height: 4),
              if (offer.minTraderLevel != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: colors.goldSubtle,
                    borderRadius: shape.radiusXS,
                  ),
                  child: Text(
                    'LL${offer.minTraderLevel}',
                    style: typo.labelSmall.copyWith(color: colors.gold),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
