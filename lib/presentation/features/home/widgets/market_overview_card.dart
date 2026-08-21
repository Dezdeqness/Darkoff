import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/home/model/market_item_ui_model.dart';
import 'package:darkoff/presentation/features/home/widgets/trend_color.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class MarketOverviewCard extends StatelessWidget {
  const MarketOverviewCard({super.key, required this.item});

  final MarketItemUiModel item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      onTap: () => context.router.push(ItemDetailRoute(itemId: item.id)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 2.0,
        children: [
          Text(
            item.displayPrice,
            style: typo.titleMedium.copyWith(
              color: colors.gold,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            item.displayName,
            style: typo.bodySmall.copyWith(color: colors.textSecondary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            item.changeLabel,
            style: typo.labelMedium.copyWith(color: item.trend.color(colors)),
          ),
        ],
      ),
    );
  }
}
