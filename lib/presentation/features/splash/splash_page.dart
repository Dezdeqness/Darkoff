import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/splash/notifiers/preload_notifier.dart';
import 'package:darkoff/presentation/features/splash/state/preload_state.dart';
import 'package:darkoff/presentation/features/splash/widgets/splash_status_widget.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  Widget buildAppLogo(BuildContext context) {
    return Image.asset(
      'assets/images/splash/splash_icon_12_v2.png',
      width: 150.0,
      height: 150.0,
      fit: BoxFit.contain,
    );
  }

  Widget buildBrandTitle(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Text(
      'DARKOFF',
      style: typo.titleLarge.copyWith(
        color: colors.gold,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        letterSpacing: 6,
      ),
    );
  }

  Widget buildBrandSubTitle(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Text(
      'TARKOV COMPANION',
      style: typo.labelSmall.copyWith(
        color: colors.textTertiary,
        letterSpacing: 4,
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;

    ref.listen<PreloadState>(preloadProvider, (_, state) {
      state.whenOrNull(
        completed: () {
          context.router.replace(const TarkovShellRoute());
        },
      );
    });

    final state = ref.watch(preloadProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SlideFadeWidget(
                  delay: Duration.zero,
                  offset: 40,
                  child: buildAppLogo(context),
                ),
                SlideFadeWidget(
                  delay: Duration(milliseconds: 500),
                  direction: SlideDirection.left,
                  child: buildBrandTitle(context),
                ),
                const SizedBox(height: 10),
                SlideFadeWidget(
                  delay: Duration(milliseconds: 500),
                  direction: SlideDirection.right,
                  child: buildBrandSubTitle(context),
                ),
                const SizedBox(height: 42),
                SlideFadeWidget(
                  direction: SlideDirection.none,
                  delay: const Duration(milliseconds: 1000),
                  onCompleted: () {
                    ref.read(preloadProvider.notifier).startPreload();
                  },
                  child: SplashStatusWidget(
                    mode: state.when(
                      initial: () => StatusMode.loading,
                      loading: (_) => StatusMode.loading,
                      completed: () => StatusMode.done,
                      error: (_) => StatusMode.error,
                    ),
                    onRetry: () => ref.read(preloadProvider.notifier).retry(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
