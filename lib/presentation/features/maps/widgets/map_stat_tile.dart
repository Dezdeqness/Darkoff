import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class MapStatTile extends StatelessWidget {
  const MapStatTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: shape.radiusMD,
        ),
        child: Column(
          children: [
            Icon(icon, size: 18, color: colors.gold),
            const SizedBox(height: 6),
            Text(
              value,
              style: typo.labelMedium.copyWith(
                color: colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label.toUpperCase(),
              style: typo.labelSmall.copyWith(
                color: colors.textTertiary,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
