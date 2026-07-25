import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_image.dart';
import 'package:darkoff/presentation/features/boss_detail/model/boss_loot_ui_model.dart';
import 'package:flutter/material.dart';

class BossLootRow extends StatelessWidget {
  const BossLootRow({super.key, required this.item});
  final BossLootUiModel item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return InkWell(
      onTap: () => context.router.push(ItemDetailRoute(itemId: item.id)),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: shape.radiusMD,
        ),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: AppImage(
                imageUrl: item.iconUrl ?? '',
                width: 40,
                height: 40,
                backgroundColor: colors.background,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                style: typo.paragraphSmall.copyWith(color: colors.textPrimary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                _priceLine(
                  context,
                  label: 'Flea',
                  value: item.fleaPrice,
                  color: colors.gold,
                ),
                const SizedBox(height: 2),
                _priceLine(
                  context,
                  label: 'Trader',
                  value: item.traderPrice,
                  color: colors.textSecondary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceLine(
    BuildContext context, {
    required String label,
    required String? value,
    required Color color,
  }) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: typo.labelSmall.copyWith(color: colors.textTertiary),
        ),
        const SizedBox(width: 6),
        Text(
          value ?? '—',
          style: typo.labelMedium.copyWith(
            color: value != null ? color : colors.textTertiary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
