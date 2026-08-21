import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/hideout_detail/model/hideout_detail_ui_model.dart';
import 'package:darkoff/presentation/features/hideout_detail/widgets/level_bonus_row.dart';
import 'package:darkoff/presentation/features/hideout_detail/widgets/level_item_row.dart';
import 'package:darkoff/presentation/features/hideout_detail/widgets/level_money_row.dart';
import 'package:darkoff/presentation/features/hideout_detail/widgets/level_prereq_row.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class LevelCardBody extends StatelessWidget {
  const LevelCardBody({
    super.key,
    required this.stationId,
    required this.model,
    required this.onSetOwned,
    required this.onToggleBuilt,
  });

  final String stationId;
  final LevelCardUiModel model;
  final void Function(String itemId, int count, int maxCount) onSetOwned;
  final VoidCallback onToggleBuilt;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Opacity(
      opacity: model.readOnly ? 0.7 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (model.prereqLabel != null) ...[
            _SectionLabel(model.prereqLabel!),
            const SizedBox(height: 6),
            ...model.prereqs.map((r) => LevelPrereqRow(prereq: r)),
            const SizedBox(height: 12),
          ],
          if (model.resourcesLabel != null) ...[
            _SectionLabel(model.resourcesLabel!),
            const SizedBox(height: 6),
            ...model.items.map(
              (r) => LevelItemRow(
                row: r,
                readOnly: model.readOnly,
                onChanged: (v) => onSetOwned(r.itemId, v, r.maxCount),
              ),
            ),
          ],
          ...model.currencies.map(
            (r) => LevelMoneyRow(
              key: ValueKey('$stationId|${model.level}|${r.itemId}'),
              row: r,
              readOnly: model.readOnly,
              onChanged: (v) => onSetOwned(r.itemId, v, r.requiredCount),
            ),
          ),
          if (model.bonuses.isNotEmpty) ...[
            const SizedBox(height: 12),
            _SectionLabel(tr.hideoutDetail.section.bonuses),
            const SizedBox(height: 6),
            ...model.bonuses.map((b) => LevelBonusRow(text: b)),
          ],
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: model.readOnly
                ? TextButton(
                    onPressed: onToggleBuilt,
                    child: Text(
                      tr.hideoutDetail.action.unmarkBuilt,
                      style: typo.labelMedium
                          .copyWith(color: colors.textSecondary),
                    ),
                  )
                : OutlinedButton.icon(
                    onPressed: onToggleBuilt,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colors.gold,
                      side: BorderSide(color: colors.gold),
                    ),
                    icon: const Icon(Icons.check, size: 16),
                    label: Text(tr.hideoutDetail.action.markBuilt),
                  ),
          ),
        ],
      ),
    );
  }
}

class LevelLockedBody extends StatelessWidget {
  const LevelLockedBody({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: shape.radiusSM,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.lock_outline, size: 14, color: colors.textTertiary),
          const SizedBox(width: 6),
          Text(
            message,
            style: typo.paragraphSmall.copyWith(color: colors.textTertiary),
          ),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    return Text(
      text,
      style: typo.labelSmall.copyWith(
        color: colors.textTertiary,
        letterSpacing: 1.5,
      ),
    );
  }
}
