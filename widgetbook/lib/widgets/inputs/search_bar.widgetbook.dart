import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final searchBarComponent = WidgetbookComponent(
  name: 'AppSearchBar',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final hintText = context.knobs.string(
          label: 'Hint text',
          initialValue: 'Search...',
        );
        final enabled = context.knobs.boolean(
          label: 'Enabled',
          initialValue: true,
        );
        final controller = TextEditingController();
        return Center(
          child: AppSearchBar(
            controller: controller,
            onChanged: (_) {},
            hintText: hintText,
            enabled: enabled,
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Read only',
      builder: (context) {
        final text = context.knobs.string(
          label: 'Value',
          initialValue: 'Read only text',
        );
        final controller = TextEditingController(text: text);
        return Center(
          child: AppSearchBar(
            controller: controller,
            onChanged: (_) {},
            readOnlyMode: true,
            onTap: () {},
          ),
        );
      },
    ),
  ],
);
