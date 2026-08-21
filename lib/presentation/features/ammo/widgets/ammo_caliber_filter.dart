import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/ammo/model/ammo_list_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class AmmoCaliberFilter extends StatelessWidget {
  const AmmoCaliberFilter({
    super.key,
    required this.calibers,
    required this.selected,
    required this.onSelected,
  });

  final List<AmmoCaliberOption> calibers;
  final String? selected;
  final ValueChanged<String?> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            AppFilterChip(
              label: tr.common.filter.all,
              isActive: selected == null,
              onTap: () => onSelected(null),
            ),
            ...calibers.map(
              (c) => Padding(
                padding: const EdgeInsets.only(left: 8),
                child: AppFilterChip(
                  label: c.label,
                  isActive: selected == c.value,
                  onTap: () => onSelected(c.value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
