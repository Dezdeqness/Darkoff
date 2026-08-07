import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/animated_progress_bar.dart';
import 'package:flutter/material.dart';

enum StatusMode { loading, error, done }

class SplashStatusWidget extends StatelessWidget {
  const SplashStatusWidget({
    super.key,
    this.mode = StatusMode.loading,
    this.onRetry,
  });

  final StatusMode mode;
  final VoidCallback? onRetry;

  Widget buildStatusText(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final isError = mode == StatusMode.error;
    final isDone = mode == StatusMode.done;

    final text = switch (mode) {
      StatusMode.loading => tr.splash.status.loading,
      StatusMode.done => tr.splash.status.ready,
      StatusMode.error => tr.common.action.tryAgain,
    };

    final color = isError
        ? colors.loss
        : isDone
        ? colors.gold
        : colors.textSecondary;

    final child = Text(text, style: typo.bodyMedium.copyWith(color: color));

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 200),
      opacity: 1.0,
      child: isError
          ? GestureDetector(
              onTap: onRetry,
              behavior: HitTestBehavior.opaque,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  child,
                  const SizedBox(width: 6),
                  Icon(Icons.refresh_rounded, size: 16, color: colors.loss),
                ],
              ),
            )
          : child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDone = mode == StatusMode.done;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedProgressBar(value: isDone ? 1.0 : null),

        const SizedBox(height: 20),

        SizedBox(
          height: 24,
          child: Center(
            child: buildStatusText(context),
          ),
        ),
      ],
    );
  }
}
