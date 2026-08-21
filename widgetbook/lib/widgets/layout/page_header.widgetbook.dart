import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final pageHeaderComponent = WidgetbookComponent(
  name: 'PageHeader',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final title = context.knobs.string(
          label: 'Title',
          initialValue: 'Page Title',
        );
        final subtitle = context.knobs.stringOrNull(
          label: 'Subtitle',
        );
        final showBack = context.knobs.boolean(
          label: 'Show back button',
          initialValue: true,
        );
        return PageHeader(
          title: title,
          subtitle: subtitle,
          showBack: showBack,
        );
      },
    ),
    WidgetbookUseCase(
      name: 'With trailing widget',
      builder: (context) {
        final title = context.knobs.string(
          label: 'Title',
          initialValue: 'Settings',
        );
        return PageHeader(
          title: title,
          showBack: false,
          trailing: IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {},
          ),
        );
      },
    ),
  ],
);
