import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final infoRowComponent = WidgetbookComponent(
  name: 'AppInfoRow',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final label = context.knobs.string(
          label: 'Label',
          initialValue: 'Weight',
        );
        final value = context.knobs.string(
          label: 'Value',
          initialValue: '2.4 kg',
        );
        return Padding(
          padding: const EdgeInsets.all(16),
          child: AppInfoRow(label: label, value: value),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Colored value',
      builder: (context) {
        final label = context.knobs.string(
          label: 'Label',
          initialValue: 'Profit',
        );
        final value = context.knobs.string(
          label: 'Value',
          initialValue: '+15,000 ₽',
        );
        final color = context.knobs.color(
          label: 'Value color',
          initialValue: const Color(0xFF4A7C59),
        );
        return Padding(
          padding: const EdgeInsets.all(16),
          child: AppInfoRow(
            label: label,
            value: value,
            valueColor: color,
          ),
        );
      },
    ),
  ],
);
