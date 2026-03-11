import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/splash/notifiers/preload_notifier.dart';
import 'package:darkoff/presentation/features/splash/state/preload_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<PreloadState>(preloadProvider, (_, state) {
      state.whenOrNull(
        completed: () {
          context.router.replace(const TarkovShellRoute());
        },
      );
    });

    final state = ref.watch(preloadProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: state.when(
            initial: () => const CircularProgressIndicator(),
            loading: (loadedCount) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 24),
                Text(
                  'Loading items...',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (loadedCount > 0) ...[
                  const SizedBox(height: 8),
                  Text(
                    '$loadedCount items loaded',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
            completed: () => const SizedBox.shrink(),
            error: (message) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                Text(
                  'Failed to load data',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: () {
                    ref.read(preloadProvider.notifier).retry();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
