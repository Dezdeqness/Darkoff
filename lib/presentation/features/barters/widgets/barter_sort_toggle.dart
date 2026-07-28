import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_filter_chip.dart';
import 'package:flutter/material.dart';

class BarterSortToggle extends StatelessWidget {
  const BarterSortToggle({
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
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          Text(
            'SORT',
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
