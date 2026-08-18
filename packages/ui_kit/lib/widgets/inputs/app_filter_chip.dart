import 'package:ui_kit/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.icon,
  });

  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? colors.goldSubtle : colors.surface,
          border:
              isActive ? colors.activeChipBorder : colors.inactiveChipBorder,
          borderRadius: BorderRadius.circular(20),
        ),
        child: icon != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon,
                      size: 14,
                      color: isActive ? colors.gold : colors.textSecondary),
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: typo.labelMedium.copyWith(
                      color: isActive ? colors.gold : colors.textSecondary,
                    ),
                  ),
                ],
              )
            : Text(
                label,
                style: typo.labelMedium.copyWith(
                  color: isActive ? colors.gold : colors.textSecondary,
                ),
              ),
      ),
    );
  }
}

class AppFilterChipRow extends StatelessWidget {
  const AppFilterChipRow({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    this.topPadding = 12,
    this.height = 40,
  });

  final List<ChipItem> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final double topPadding;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: SizedBox(
        height: height,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: items.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (ctx, i) => AppFilterChip(
            label: items[i].label,
            isActive: selectedIndex == i,
            onTap: () => onSelected(i),
            icon: items[i].icon,
          ),
        ),
      ),
    );
  }
}

class ChipItem {
  const ChipItem(this.label, {this.icon});
  final String label;
  final IconData? icon;
}

extension ChipItems on List<String> {
  List<ChipItem> toChipItems() => map((s) => ChipItem(s)).toList();
}

List<ChipItem> chipItems(List<(String, IconData?)> pairs) =>
    pairs.map((p) => ChipItem(p.$1, icon: p.$2)).toList();
