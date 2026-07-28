import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/maps/model/map_ui_model.dart';
import 'package:flutter/material.dart';

class MapCard extends StatelessWidget {
  const MapCard({super.key, required this.map});

  final MapUiModel map;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
      child: GestureDetector(
        onTap: () => context.router.push(MapDetailRoute(mapId: map.id)),
        behavior: HitTestBehavior.opaque,
        child: Container(
          decoration: BoxDecoration(
            color: colors.surface,
            border: Border.all(color: colors.border),
            borderRadius: shape.radiusMD,
          ),
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: colors.goldSubtle,
                  borderRadius: shape.radiusSM,
                ),
                child: Icon(Icons.map_outlined, color: colors.gold, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      map.name,
                      style: typo.labelLarge.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (map.description != null) ...[
                      const SizedBox(height: 3),
                      Text(
                        map.description!,
                        style: typo.paragraphSmall.copyWith(
                          color: colors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.people_outline,
                          label: map.playersLabel,
                        ),
                        const SizedBox(width: 8),
                        _InfoChip(
                          icon: Icons.timer_outlined,
                          label: map.durationLabel,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: colors.textTertiary, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 10, color: colors.textTertiary),
        const SizedBox(width: 3),
        Text(
          label,
          style: typo.paragraphSmall.copyWith(color: colors.textTertiary),
        ),
      ],
    );
  }
}
