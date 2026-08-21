import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final errorStatesComponent = WidgetbookComponent(
  name: 'Error States',
  useCases: [
    WidgetbookUseCase(
      name: 'AppErrorView',
      builder: (context) {
        final message = context.knobs.string(
          label: 'Message',
          initialValue: 'Failed to load data',
        );
        final retryLabel = context.knobs.string(
          label: 'Retry label',
          initialValue: 'Retry',
        );
        final icon = context.knobs.object.dropdown(
          label: 'Icon',
          options: [
            Icons.error_outline,
            Icons.wifi_off,
            Icons.cloud_off,
            Icons.sync_problem,
          ],
          initialOption: Icons.error_outline,
          labelBuilder: (icon) => icon.toString().split('.').last,
        );
        return Center(
          child: AppErrorView(
            message: message,
            onRetry: () {},
            retryLabel: retryLabel,
            icon: icon,
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'SliverErrorMessage',
      builder: (context) {
        final message = context.knobs.string(
          label: 'Message',
          initialValue: 'Something went wrong',
        );
        final retryLabel = context.knobs.string(
          label: 'Retry label',
          initialValue: 'Retry',
        );
        return Center(
          child: CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverErrorMessage(
                message: message,
                onRetry: () {},
                retryLabel: retryLabel,
              ),
            ],
          ),
        );
      },
    ),
  ],
);
