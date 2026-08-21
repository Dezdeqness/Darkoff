import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final cardsComponent = WidgetbookComponent(
  name: 'AppCard',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final content = context.knobs.string(
          label: 'Content',
          initialValue: 'Card content',
        );
        final padding = context.knobs.doubleOrNull.slider(
          label: 'Padding',
          initialValue: 16,
          min: 0,
          max: 48,
          divisions: 12,
        );
        final shape = context.knobs.double.slider(
          label: 'Shape',
          initialValue: 16,
          min: 0,
          max: 48,
          divisions: 12,
        );
        return Center(
          child: AppCard(
            padding: EdgeInsets.all(padding ?? 16),
            borderRadius: BorderRadius.circular(shape),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                content,
                style: TextStyle(color: context.colorTheme.textPrimary),
              ),
            ),
          ),
        );
      },
    ),
  ],
);
