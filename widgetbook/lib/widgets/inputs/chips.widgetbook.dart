import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final chipsComponent = WidgetbookComponent(
  name: 'AppFilterChip',
  useCases: [
    WidgetbookUseCase(
      name: 'Single Chip',
      builder: (context) {
        final label = context.knobs.string(
          label: 'Label',
          initialValue: 'Active Chip',
        );
        final isActive = context.knobs.boolean(
          label: 'Is active',
          initialValue: true,
        );
        final hasIcon = context.knobs.boolean(
          label: 'Show icon',
          initialValue: false,
        );
        return Center(
          child: AppFilterChip(
            label: label,
            isActive: isActive,
            icon: hasIcon ? Icons.filter_alt_outlined : null,
            onTap: () {},
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Chip Row',
      builder: (context) {
        final selectedIndex = context.knobs.int.slider(
          label: 'Selected index',
          initialValue: 0,
          min: 0,
          max: 4,
        );
        return AppFilterChipRow(
          items: const [
            ChipItem('All'),
            ChipItem('Weapons'),
            ChipItem('Armor'),
            ChipItem('Medical'),
            ChipItem('Keys'),
          ],
          selectedIndex: selectedIndex,
          onSelected: (_) {},
        );
      },
    ),
  ],
);
