import 'package:darkoff/core/localization/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TraderLevelFilter extends StatelessWidget {
  const TraderLevelFilter({
    super.key,
    required this.levels,
    required this.selected,
    required this.onSelect,
  });

  final List<int> levels;
  final int? selected;
  final ValueChanged<int?> onSelect;

  @override
  Widget build(BuildContext context) {
    if (levels.length < 2) return const SizedBox.shrink();

    return SizedBox(
      height: 52,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Center(
            child: AppFilterChip(
              label: tr.common.filter.all,
              isActive: selected == null,
              onTap: () => onSelect(null),
            ),
          ),
          ...levels.map(
            (l) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Center(
                child: AppFilterChip(
                  label: 'L$l',
                  isActive: selected == l,
                  onTap: () => onSelect(l),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
