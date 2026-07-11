import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/hideout_detail/model/hideout_detail_ui_model.dart';
import 'package:flutter/material.dart';

class LevelPrereqRow extends StatelessWidget {
  const LevelPrereqRow({super.key, required this.prereq});

  final PrereqRowUiModel prereq;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    final icon = prereq.met
        ? Icons.check
        : prereq.isTrader
            ? Icons.person_outline
            : Icons.home_work_outlined;
    final color = prereq.met ? colors.profit : colors.textSecondary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 6),
          Text(
            prereq.label,
            style: typo.paragraphSmall.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
