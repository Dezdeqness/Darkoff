import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final slideFadeComponent = WidgetbookComponent(
  name: 'SlideFadeWidget',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final direction = context.knobs.object.dropdown(
          label: 'Direction',
          options: SlideDirection.values,
          initialOption: SlideDirection.top,
          labelBuilder: (dir) => dir.name[0].toUpperCase() + dir.name.substring(1),
        );
        final offset = context.knobs.doubleOrNull.slider(
          label: 'Offset',
          initialValue: 90,
          min: 10,
          max: 200,
          divisions: 19,
        );
        final duration = context.knobs.duration(
          label: 'Duration',
          initialValue: const Duration(milliseconds: 750),
        );
        final text = context.knobs.string(
          label: 'Text',
          initialValue: 'SlideFade content',
        );
        return Center(
          child: SlideFadeWidget(
            direction: direction,
            offset: offset ?? 90,
            duration: duration,
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        );
      },
    ),
  ],
);
