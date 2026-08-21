import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final recipeItemRowComponent = WidgetbookComponent(
  name: 'RecipeItemRow',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final label = context.knobs.string(
          label: 'Label',
          initialValue: 'Duct tape',
        );
        return Padding(
          padding: const EdgeInsets.all(16),
          child: RecipeItemRow(
            iconLink: null,
            label: label,
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Emphasized',
      builder: (context) {
        final label = context.knobs.string(
          label: 'Label',
          initialValue: 'Military cable',
        );
        final emphasize = context.knobs.boolean(
          label: 'Emphasize',
          initialValue: true,
        );
        return Padding(
          padding: const EdgeInsets.all(16),
          child: RecipeItemRow(
            iconLink: null,
            label: label,
            emphasize: emphasize,
          ),
        );
      },
    ),
  ],
);
