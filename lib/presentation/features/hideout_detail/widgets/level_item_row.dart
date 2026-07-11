import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/item_icon.dart';
import 'package:darkoff/presentation/features/hideout_detail/model/hideout_detail_ui_model.dart';
import 'package:flutter/material.dart';

class LevelItemRow extends StatelessWidget {
  const LevelItemRow({
    super.key,
    required this.row,
    required this.readOnly,
    required this.onChanged,
  });

  final ItemReqRowUiModel row;
  final bool readOnly;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ItemIcon(
            imageUrl: row.iconLink,
            fallbackIcon: Icons.inventory_2_outlined,
            size: 32,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.shortName,
                  style: typo.labelMedium.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  row.subtitle,
                  style: typo.paragraphSmall.copyWith(
                    color: row.met ? colors.profit : colors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (readOnly)
            Text(
              row.countText,
              style: typo.labelMedium.copyWith(
                color: colors.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            )
          else
            _QtyControl(
              value: row.owned,
              max: row.maxCount,
              met: row.met,
              onChanged: onChanged,
            ),
        ],
      ),
    );
  }
}

class _QtyControl extends StatelessWidget {
  const _QtyControl({
    required this.value,
    required this.max,
    required this.met,
    required this.onChanged,
  });

  final int value;
  final int max;
  final bool met;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: colors.background,
        border: Border.all(color: met ? colors.profit : colors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _QtyButton(
            icon: Icons.remove,
            enabled: value > 0,
            onTap: () => onChanged(value - 1),
          ),
          SizedBox(
            width: 30,
            child: Text(
              '$value',
              textAlign: TextAlign.center,
              style: typo.labelMedium.copyWith(
                color: met ? colors.profit : colors.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text('/', style: typo.paragraphSmall.copyWith(color: colors.border)),
          SizedBox(
            width: 26,
            child: Text(
              '$max',
              textAlign: TextAlign.center,
              style: typo.paragraphSmall.copyWith(color: colors.textSecondary),
            ),
          ),
          _QtyButton(
            icon: Icons.add,
            enabled: value < max,
            onTap: () => onChanged(value + 1),
          ),
        ],
      ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.icon,
    required this.enabled,
    required this.onTap,
  });

  final IconData icon;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    return Opacity(
      opacity: enabled ? 1 : 0.3,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: colors.surfaceHigh,
            border: Border.all(color: colors.border),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(icon, size: 14, color: colors.gold),
        ),
      ),
    );
  }
}
