import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final progressComponent = WidgetbookComponent(
  name: 'Progress',
  useCases: [
    WidgetbookUseCase(
      name: 'AnimatedProgressBar',
      builder: (context) {
        final hasValue = context.knobs.boolean(
          label: 'Determinate',
          initialValue: false,
        );
        final value = context.knobs.double.slider(
          label: 'Value',
          initialValue: 0.5,
          min: 0,
          max: 1,
          divisions: 20,
        );
        final width = context.knobs.double.slider(
          label: 'Width',
          initialValue: 240,
          min: 80,
          max: 400,
          divisions: 16,
        );
        return Center(
          child: AnimatedProgressBar(
            value: hasValue ? value : null,
            width: width,
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'SliverLoadingIndicator',
      builder: (context) {
        final padding = context.knobs.double.slider(
          label: 'Padding',
          initialValue: 48,
          min: 0,
          max: 96,
          divisions: 8,
        );
        return CustomScrollView(
          slivers: [
            SliverLoadingIndicator(padding: padding),
          ],
        );
      },
    ),
  ],
);
