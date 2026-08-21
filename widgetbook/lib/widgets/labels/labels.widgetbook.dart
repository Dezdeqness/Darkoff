import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final labelsComponent = WidgetbookComponent(
  name: 'Labels',
  useCases: [
    WidgetbookUseCase(
      name: 'AppLabel',
      builder: (context) {
        final text = context.knobs.string(
          label: 'Text',
          initialValue: 'NEW',
        );
        return Center(
          child: AppLabel(text: text),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'AppSectionHeader',
      builder: (context) {
        final title = context.knobs.string(
          label: 'Title',
          initialValue: 'SECTION TITLE',
        );
        return AppSectionHeader(title: title);
      },
    ),
    WidgetbookUseCase(
      name: 'SectionLabel',
      builder: (context) {
        final text = context.knobs.string(
          label: 'Text',
          initialValue: 'SECTION LABEL',
        );
        final letterSpacing = context.knobs.doubleOrNull.slider(
          label: 'Letter spacing',
          initialValue: 2.0,
          min: 0,
          max: 6,
          divisions: 12,
        );
        return SectionLabel(
          text,
          letterSpacing: letterSpacing ?? 2.0,
        );
      },
    ),
  ],
);
