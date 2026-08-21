import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class MapEnemyChip extends StatelessWidget {
  const MapEnemyChip({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name,
        style: typo.paragraphSmall.copyWith(color: colors.textSecondary),
      ),
    );
  }
}
