import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/keys/model/keys_list_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class KeyRow extends StatelessWidget {
  const KeyRow({super.key, required this.row});

  final KeyRowUiModel row;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return AppCard(
      padding: const EdgeInsets.all(10),
      onTap: () => context.router.push(ItemDetailRoute(itemId: row.id)),
      child: Row(
        children: [
          ItemIcon(imageUrl: row.iconLink, fallbackIcon: Icons.key_outlined),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.name,
                  style: typo.labelMedium.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (row.categoryLabel != null)
                  Text(
                    row.categoryLabel!,
                    style: typo.paragraphSmall.copyWith(
                      color: colors.textTertiary,
                    ),
                  ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                row.priceLabel,
                style: row.hasPrice
                    ? typo.labelMedium.copyWith(
                        color: colors.gold,
                        fontWeight: FontWeight.w600,
                      )
                    : typo.paragraphSmall.copyWith(color: colors.textTertiary),
              ),
              if (row.lowPriceLabel != null)
                Text(
                  row.lowPriceLabel!,
                  style: typo.paragraphSmall.copyWith(
                    color: colors.textTertiary,
                    fontSize: 10,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
