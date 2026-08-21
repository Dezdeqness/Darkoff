import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final itemIconComponent = WidgetbookComponent(
  name: 'ItemIcon',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final size = context.knobs.double.slider(
          label: 'Size',
          initialValue: 48,
          min: 24,
          max: 60,
          divisions: 12,
        );
        final useGold = context.knobs.boolean(
          label: 'Gold background',
          initialValue: false,
        );
        return Center(
          child: ItemIcon(
            size: size,
            useGoldBackground: useGold,
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Custom icon',
      builder: (context) {
        final icon = context.knobs.object.dropdown(
          label: 'Fallback icon',
          options: [
            Icons.star,
            Icons.inventory_2_outlined,
            Icons.gps_fixed,
            Icons.lock_outline,
            Icons.local_fire_department_outlined,
          ],
          initialOption: Icons.star,
          labelBuilder: (icon) => icon.toString().split('.').last,
        );
        final size = context.knobs.double.slider(
          label: 'Size',
          initialValue: 48,
          min: 24,
          max: 60,
          divisions: 4,
        );
        final useGold = context.knobs.boolean(
          label: 'Gold background',
          initialValue: true,
        );
        return Center(
          child: ItemIcon(
            size: size,
            useGoldBackground: useGold,
            fallbackIcon: icon,
          ),
        );
      },
    ),
  ],
);
