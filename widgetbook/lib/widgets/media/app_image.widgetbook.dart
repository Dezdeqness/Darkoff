import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final appImageComponent = WidgetbookComponent(
  name: 'AppImage',
  useCases: [
    WidgetbookUseCase(
      name: 'With URL',
      builder: (context) {
        final url = context.knobs.string(
          label: 'Image URL',
          initialValue: 'https://placehold.co/200x200',
        );
        final width = context.knobs.doubleOrNull.slider(
          label: 'Width',
          initialValue: 200,
          min: 48,
          max: 400,
          divisions: 16,
        );
        final height = context.knobs.doubleOrNull.slider(
          label: 'Height',
          initialValue: 200,
          min: 48,
          max: 400,
          divisions: 16,
        );
        final radius = context.knobs.doubleOrNull.slider(
          label: 'Border radius',
          initialValue: 0,
          min: 0,
          max: 48,
          divisions: 12,
        );
        return Center(
          child: AppImage(
            imageUrl: url,
            width: width,
            height: height,
            borderRadius: radius != null && radius > 0
                ? BorderRadius.all(Radius.circular(radius))
                : null,
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Empty URL (placeholder)',
      builder: (context) {
        final width = context.knobs.doubleOrNull.slider(
          label: 'Width',
          initialValue: 200,
          min: 48,
          max: 400,
          divisions: 16,
        );
        final height = context.knobs.doubleOrNull.slider(
          label: 'Height',
          initialValue: 200,
          min: 48,
          max: 400,
          divisions: 16,
        );
        return Center(
          child: AppImage(
            imageUrl: '',
            width: width,
            height: height,
          ),
        );
      },
    ),
  ],
);
