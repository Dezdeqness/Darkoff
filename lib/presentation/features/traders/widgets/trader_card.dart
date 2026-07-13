import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:darkoff/core/widgets/item_icon.dart';
import 'package:darkoff/domain/entities/trader_entity.dart';
import 'package:darkoff/presentation/features/traders/widgets/trader_reset_label.dart';
import 'package:flutter/material.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({super.key, required this.trader});

  final TraderEntity trader;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return AppCard(
      onTap: () => context.router.push(
        TradersDetailRoute(traderId: trader.id),
      ),
      child: Row(
        children: [
          ItemIcon(
            imageUrl: trader.imageLink,
            fallbackIcon: Icons.person_outline,
            size: 48,
            useGoldBackground: true,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trader.name,
                  style: typo.labelLarge.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.storefront_outlined,
                        size: 13, color: colors.gold),
                    const SizedBox(width: 4),
                    Text(
                      '${trader.cashOffers.length} offers · '
                      '${trader.barters.length} barters',
                      style: typo.paragraphSmall
                          .copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 12, color: colors.textSecondary),
                    const SizedBox(width: 4),
                    TraderResetLabel(
                      resetTime: trader.resetTime,
                      style: typo.paragraphSmall
                          .copyWith(color: colors.textSecondary),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: colors.textTertiary, size: 20),
        ],
      ),
    );
  }
}
