import 'package:darkoff/core/localization/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class HomePlaceholderWidget extends StatelessWidget {
  const HomePlaceholderWidget({
    super.key,
    required this.height,
    required this.message,
    this.onRetry,
  });

  final double height;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: typo.bodySmall.copyWith(color: colors.textSecondary),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                child: Text(tr.common.action.retry, style: TextStyle(color: colors.gold)),
              ),
          ],
        ),
      ),
    );
  }
}