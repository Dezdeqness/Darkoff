import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final emptyStatesComponent = WidgetbookComponent(
  name: 'Empty States',
  useCases: [
    WidgetbookUseCase(
      name: 'AppEmptyView',
      builder: (context) {
        final message = context.knobs.string(
          label: 'Message',
          initialValue: 'No items found',
        );
        final icon = context.knobs.object.dropdown(
          label: 'Icon',
          options: [
            Icons.inbox_outlined,
            Icons.search_off,
            Icons.filter_list_off,
            Icons.folder_off,
          ],
          initialOption: Icons.inbox_outlined,
          labelBuilder: (icon) => icon.toString().split('.').last,
        );
        return Center(
          child: AppEmptyView(message: message, icon: icon),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'SliverEmptyMessage',
      builder: (context) {
        final message = context.knobs.string(
          label: 'Message',
          initialValue: 'Nothing to show here',
        );
        return Center(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverEmptyMessage(message: message),
            ],
          ),
        );
      },
    ),
  ],
);
