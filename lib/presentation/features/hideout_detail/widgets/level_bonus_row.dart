import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class LevelBonusRow extends StatelessWidget {
  const LevelBonusRow({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(Icons.star_outline, size: 12, color: colors.profit),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: typo.paragraphSmall.copyWith(color: colors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
