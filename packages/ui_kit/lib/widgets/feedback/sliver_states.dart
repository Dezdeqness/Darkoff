import 'package:flutter/material.dart';
import 'package:ui_kit/widgets/feedback/app_empty_view.dart';
import 'package:ui_kit/widgets/feedback/app_error_view.dart';

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
    this.retryLabel = 'Retry',
  });

  final String message;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: AppErrorView(
        message: message,
        onRetry: onRetry,
        retryLabel: retryLabel,
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
      child: AppEmptyView(message: message),
    );
  }
}
