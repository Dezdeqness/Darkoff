import 'package:darkoff/presentation/features/boss_detail/model/boss_detail_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BossSpawnCard extends StatelessWidget {
  const BossSpawnCard({super.key, required this.spawn});
  final BossSpawnUiModel spawn;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;
    final tierColor = _tierColor(spawn.tier);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: shape.radiusMD,
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  spawn.mapName,
                  style: typo.labelMedium.copyWith(
                    color: colors.gold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: tierColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: tierColor.withAlpha(80)),
                ),
                child: Text(
                  spawn.chanceLabel,
                  style: typo.labelSmall.copyWith(
                    color: tierColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          if (spawn.locations != null) ...[
            const SizedBox(height: 4),
            Text(
              spawn.locations!,
              style: typo.paragraphSmall.copyWith(color: colors.textTertiary),
            ),
          ],
          if (spawn.escorts.isNotEmpty) ...[
            const SizedBox(height: 6),
            ...spawn.escorts.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 11,
                      color: colors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        e,
                        style: typo.paragraphSmall.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Color _tierColor(SpawnChanceTier tier) => switch (tier) {
    SpawnChanceTier.high => const Color(0xFF4CAF50),
    SpawnChanceTier.medium => const Color(0xFFFFB300),
    SpawnChanceTier.low => const Color(0xFFE53935),
  };
}
