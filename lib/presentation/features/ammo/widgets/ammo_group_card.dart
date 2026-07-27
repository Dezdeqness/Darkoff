import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/ammo/model/ammo_list_ui_model.dart';
import 'package:darkoff/presentation/features/ammo/widgets/ammo_row.dart';
import 'package:flutter/material.dart';

class AmmoGroupCard extends StatelessWidget {
  const AmmoGroupCard({super.key, required this.group});

  final AmmoGroupUiModel group;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            group.caliberLabel,
            style: typo.labelMedium.copyWith(
              color: colors.gold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.border),
              borderRadius: shape.radiusMD,
            ),
            child: Column(
              children: [
                const _AmmoHeaderRow(),
                ...group.rows.asMap().entries.map(
                  (e) => AmmoRow(
                    row: e.value,
                    showDivider: e.key < group.rows.length - 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AmmoHeaderRow extends StatelessWidget {
  const _AmmoHeaderRow();

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final style = typo.labelSmall.copyWith(color: colors.textTertiary);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(flex: 3, child: Text('NAME', style: style)),
          SizedBox(
            width: 40,
            child: Text('DMG', style: style, textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 40,
            child: Text('PEN', style: style, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
