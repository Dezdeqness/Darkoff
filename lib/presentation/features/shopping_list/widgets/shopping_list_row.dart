import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/item_icon.dart';
import 'package:darkoff/presentation/features/shopping_list/model/shopping_list_ui_model.dart';
import 'package:flutter/material.dart';

class ShoppingListRow extends StatelessWidget {
  const ShoppingListRow({super.key, required this.model});

  final ShoppingListRowUiModel model;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ItemIcon(
            imageUrl: model.iconLink,
            fallbackIcon: Icons.inventory_2_outlined,
            size: 36,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.shortName,
                  style: typo.labelMedium.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  model.sourcesText,
                  style:
                      typo.paragraphSmall.copyWith(color: colors.textTertiary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                model.countText,
                style: typo.labelMedium.copyWith(
                  color: colors.gold,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (model.displayCost != null)
                Text(
                  model.displayCost!,
                  style: typo.paragraphSmall
                      .copyWith(color: colors.textSecondary),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShoppingListSummaryCard extends StatelessWidget {
  const ShoppingListSummaryCard({super.key, required this.model});

  final ShoppingListUiModel model;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Container(
        decoration: BoxDecoration(
          color: colors.goldSubtle,
          border: colors.activeChipBorder,
          borderRadius: shape.radiusMD,
        ),
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.shopping_cart_outlined, color: colors.gold, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: typo.labelMedium.copyWith(color: colors.gold),
                  ),
                  Text(
                    tr.shoppingList.fleaEstimate,
                    style: typo.paragraphSmall
                        .copyWith(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            if (model.displayCost != null)
              Text(
                model.displayCost!,
                style: typo.labelLarge.copyWith(
                  color: colors.gold,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
