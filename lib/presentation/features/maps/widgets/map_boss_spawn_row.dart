import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/maps/model/map_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class MapBossSpawnRow extends StatelessWidget {
  const MapBossSpawnRow({super.key, required this.boss});

  final MapBossUiModel boss;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return GestureDetector(
      onTap: () => context.router.push(BossDetailRoute(bossId: boss.id)),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: shape.radiusMD,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: shape.radiusSM,
                child: boss.portraitUrl != null
                    ? Image.network(
                        boss.portraitUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, e, st) => _fallback(colors),
                      )
                    : _fallback(colors),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                boss.name,
                style: typo.labelMedium.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (boss.spawnChanceLabel != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: colors.goldSubtle,
                  borderRadius: shape.radiusXS,
                ),
                child: Text(
                  boss.spawnChanceLabel!,
                  style: typo.labelSmall.copyWith(
                    color: colors.gold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _fallback(ColorTheme colors) => Container(
    color: colors.goldSubtle,
    child: Icon(Icons.person_outline, color: colors.gold, size: 20),
  );
}
