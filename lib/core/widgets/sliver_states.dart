import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class SliverLoadingIndicator extends StatelessWidget {
  const SliverLoadingIndicator({super.key, this.padding = 48});

  final double padding;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class SliverErrorMessage extends StatelessWidget {
  const SliverErrorMessage({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Text(
              message,
              style: TextStyle(color: colors.loss),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: onRetry,
              child: Text(tr.common.action.retry),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverEmptyMessage extends StatelessWidget {
  const SliverEmptyMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            message,
            style: const TextStyle(color: Color(0xFF888888)),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
