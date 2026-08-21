import 'package:darkoff/presentation/features/more/model/more_menu.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class MoreMenuRow extends StatelessWidget {
  const MoreMenuRow({
    super.key,
    required this.entry,
    this.onTap,
    this.showDivider = true,
  });

  final MoreMenuEntry entry;
  final VoidCallback? onTap;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;
    final disabled = onTap == null;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Opacity(
        opacity: disabled ? 0.4 : 1,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: showDivider
              ? BoxDecoration(border: Border(bottom: BorderSide(color: colors.border)))
              : null,
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: colors.goldSubtle,
                  borderRadius: shape.radiusSM,
                ),
                child: Icon(entry.icon, color: colors.gold, size: 18),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.label,
                      style:
                          typo.labelLarge.copyWith(color: colors.textPrimary),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      entry.subtitle,
                      style: typo.paragraphSmall
                          .copyWith(color: colors.textSecondary),
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
