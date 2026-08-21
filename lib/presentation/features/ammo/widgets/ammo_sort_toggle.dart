import 'package:darkoff/core/localization/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AmmoSortToggle extends StatelessWidget {
  const AmmoSortToggle({
    super.key,
    required this.label,
    required this.onToggle,
  });

  final String label;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
      child: Row(
        children: [
          Text(
            tr.common.sort,
            style: typo.labelMedium.copyWith(
              color: colors.textTertiary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(width: 10),
          AppFilterChip(
            label: label,
            isActive: true,
            icon: Icons.swap_vert,
            onTap: onToggle,
          ),
        ],
      ),
    );
  }
}
