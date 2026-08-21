import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final badgesComponent = WidgetbookComponent(
  name: 'Badges',
  useCases: [
    WidgetbookUseCase(
      name: 'ProfitBadge',
      builder: (context) {
        final label = context.knobs.string(
          label: 'Label',
          initialValue: '+15 000 ₽',
        );
        final isPositive = context.knobs.boolean(
          label: 'Is positive',
          initialValue: true,
        );
        return Center(
          child: ProfitBadge(label: label, isPositive: isPositive),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'PercentChangeBadge',
      builder: (context) {
        final percent = context.knobs.doubleOrNull.slider(
          label: 'Percent',
          initialValue: 12.5,
          min: -50,
          max: 50,
          divisions: 20,
        );
        return Center(
          child: PercentChangeBadge(percent: percent ?? 0),
        );
      },
    ),
  ],
);
