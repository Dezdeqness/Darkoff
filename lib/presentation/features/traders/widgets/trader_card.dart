import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/traders/model/trader_list_ui_model.dart';
import 'package:darkoff/presentation/features/traders/widgets/trader_reset_label.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TraderCard extends StatelessWidget {
  const TraderCard({super.key, required this.model});

  final TraderListItemUiModel model;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return AppCard(
      onTap: () => context.router.push(
        TradersDetailRoute(traderId: model.id),
      ),
      child: Row(
        children: [
          ItemIcon(
            imageUrl: model.imageLink,
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
                  model.name,
                  style: typo.labelLarge.copyWith(color: colors.textPrimary),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.storefront_outlined,
                        size: 13, color: colors.gold),
                    const SizedBox(width: 4),
                    Text(
                      model.tradesText,
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
                      resetTime: model.resetTime,
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
