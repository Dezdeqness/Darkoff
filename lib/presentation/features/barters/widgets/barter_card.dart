import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:darkoff/core/widgets/profit_badge.dart';
import 'package:darkoff/core/widgets/recipe_item_row.dart';
import 'package:darkoff/presentation/features/barters/model/barters_list_ui_model.dart';
import 'package:flutter/material.dart';

class BarterCard extends StatelessWidget {
  const BarterCard({super.key, required this.barter});

  final BarterRowUiModel barter;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: colors.goldSubtle,
                  borderRadius: shape.radiusXS,
                ),
                child: Text(
                  barter.traderLabel,
                  style: typo.labelSmall.copyWith(color: colors.gold),
                ),
              ),
              const Spacer(),
              ProfitBadge(value: barter.profit),
            ],
          ),
          const SizedBox(height: 10),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in barter.requiredItems)
                      InkWell(
                        onTap: () => context.router.push(
                          ItemDetailRoute(itemId: barter.detailItemId!),
                        ),
                        child: RecipeItemRow(
                          iconLink: item.iconLink,
                          label: '${item.countLabel} ${item.shortName}',
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.arrow_forward,
                  color: colors.textTertiary,
                  size: 16,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final item in barter.rewardItems)
                      InkWell(
                        onTap: () => context.router.push(
                          ItemDetailRoute(itemId: barter.detailItemId!),
                        ),
                        child: RecipeItemRow(
                          iconLink: item.iconLink,
                          label: '${item.countLabel} ${item.shortName}',
                          emphasize: true,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Text(
                tr.barters.card.cost,
                style: typo.paragraphSmall.copyWith(color: colors.textTertiary),
              ),
              Text(
                barter.costLabel,
                style: typo.paragraphSmall.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(width: 12),
              Text(
                tr.barters.card.value,
                style: typo.paragraphSmall.copyWith(color: colors.textTertiary),
              ),
              Text(
                barter.valueLabel,
                style: typo.paragraphSmall.copyWith(color: colors.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
