import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/ammo/model/ammo_list_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AmmoRow extends StatelessWidget {
  const AmmoRow({super.key, required this.row, required this.showDivider});

  final AmmoRowUiModel row;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final penColor = _penColor(context);

    return InkWell(
      onTap: () => context.router.push(ItemDetailRoute(itemId: row.id)),
      child: Container(
        decoration: showDivider
            ? BoxDecoration(
                border: Border(bottom: BorderSide(color: colors.border)),
              )
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(color: penColor, shape: BoxShape.circle),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    row.shortName,
                    style: typo.labelMedium.copyWith(color: colors.textPrimary),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (row.tracer)
                    Text(
                      tr.ammo.type.tracer,
                      style: typo.paragraphSmall.copyWith(
                        color: colors.textTertiary,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                row.damage,
                style: typo.labelMedium.copyWith(color: colors.textPrimary),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 40,
              child: Text(
                row.penetration,
                style: typo.labelMedium.copyWith(
                  color: penColor,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (row.trailingLabel.isNotEmpty)
              SizedBox(
                width: 64,
                child: Text(
                  row.trailingLabel,
                  style: typo.labelSmall.copyWith(color: colors.textSecondary),
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _penColor(BuildContext context) {
    final colors = context.colorTheme;
    return switch (row.penTier) {
      AmmoPenTier.high => colors.profit,
      AmmoPenTier.mid => colors.gold,
      AmmoPenTier.low => colors.loss,
    };
  }
}
