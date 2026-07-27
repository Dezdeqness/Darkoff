import 'package:darkoff/core/widgets/app_filter_chip.dart';
import 'package:darkoff/presentation/features/keys/model/keys_list_ui_model.dart';
import 'package:flutter/material.dart';

class KeySortBar extends StatelessWidget {
  const KeySortBar({super.key, required this.chips, required this.onSelected});

  final List<KeySortChipUiModel> chips;
  final ValueChanged<KeySort> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: chips.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final chip = chips[i];
            return AppFilterChip(
              label: chip.label,
              isActive: chip.active,
              onTap: () => onSelected(chip.value),
            );
          },
        ),
      ),
    );
  }
}
