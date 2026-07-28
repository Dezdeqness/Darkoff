import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:darkoff/core/widgets/profit_badge.dart';
import 'package:darkoff/core/widgets/recipe_item_row.dart';
import 'package:darkoff/presentation/features/crafts/model/crafts_list_ui_model.dart';
import 'package:flutter/material.dart';

class CraftCard extends StatelessWidget {
  const CraftCard({super.key, required this.craft});

  final CraftRowUiModel craft;

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
                  craft.stationLabel,
                  style: typo.labelSmall.copyWith(color: colors.gold),
                ),
              ),
              const Spacer(),
              ProfitBadge(value: craft.profit),
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
                    for (final item in craft.requiredItems)
                      InkWell(
                        onTap: () => context.router.push(
                          ItemDetailRoute(itemId: item.id),
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
                    for (final item in craft.rewardItems)
                      InkWell(
                        onTap: () => context.router.push(
                          ItemDetailRoute(itemId: item.id),
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
              Icon(Icons.timer_outlined, size: 12, color: colors.textTertiary),
              const SizedBox(width: 4),
              Text(
                craft.durationLabel,
                style: typo.paragraphSmall.copyWith(color: colors.textSecondary),
              ),
              const SizedBox(width: 12),
              if (craft.profitPerHourLabel != null) ...[
                Icon(Icons.trending_up, size: 12, color: colors.profit),
                const SizedBox(width: 4),
                Text(
                  craft.profitPerHourLabel!,
                  style: typo.paragraphSmall.copyWith(color: colors.profit),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
