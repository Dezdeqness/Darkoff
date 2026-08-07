import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_error_view.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/presentation/features/boss_detail/notifiers/boss_detail_notifier.dart';
import 'package:darkoff/presentation/features/boss_detail/state/boss_detail_state.dart';
import 'package:darkoff/presentation/features/boss_detail/widgets/boss_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class BossDetailPage extends ConsumerWidget {
  const BossDetailPage({super.key, @PathParam('bossId') required this.bossId});

  final String bossId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(bossDetailProvider(bossId));

    final model = state.maybeWhen(
      loaded: (model) => model,
      orElse: () => null,
    );

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            PageHeader(
              title: model?.displayName ?? tr.bossDetail.fallback.title,
              subtitle: model?.healthLabel,
            ),
            Expanded(child: _buildContent(context, ref, state)),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    WidgetRef ref,
    BossDetailState state,
  ) {
    return switch (state) {
      BossDetailInitial() || BossDetailLoading() => const Center(
        child: CircularProgressIndicator(),
      ),
      BossDetailError() => AppErrorView(
        message: 'Failed to load boss',
        onRetry: () => ref.read(bossDetailProvider(bossId).notifier).refresh(),
      ),
      BossDetailLoaded(:final boss) => BossDetailView(
        model: boss,
        bossId: bossId,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
