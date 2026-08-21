import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/hideout/notifiers/hideout_progress_notifier.dart';
import 'package:darkoff/presentation/features/hideout_detail/model/hideout_detail_ui_model.dart';
import 'package:darkoff/presentation/features/hideout_detail/notifiers/hideout_detail_notifier.dart';
import 'package:darkoff/presentation/features/hideout_detail/state/hideout_detail_state.dart';
import 'package:darkoff/presentation/features/hideout_detail/widgets/level_card.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HideoutDetailPage extends ConsumerWidget {
  const HideoutDetailPage({
    super.key,
    @PathParam('detailId') required this.stationId,
  });

  final String stationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(hideoutDetailProvider(stationId));

    final detail = state.maybeWhen(
      loaded: (detail) => detail,
      orElse: () => null,
    );

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PageHeader(
                title: detail?.name ?? tr.hideoutDetail.fallback.title,
                trailing: detail == null
                    ? null
                    : buildTrailing(context: context, ref: ref, detail: detail),
              ),
            ),
            buildContent(context: context, ref: ref, state: state),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  Widget buildTrailing({
    required BuildContext context,
    required WidgetRef ref,
    required HideoutDetailUiModel detail,
  }) {
    final colors = context.colorTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!detail.fullyBuilt) ...[
          GestureDetector(
            onTap: () => ref
                .read(hideoutProgressProvider.notifier)
                .toggleTracked(detail.stationId),
            behavior: HitTestBehavior.opaque,
            child: Icon(
              detail.tracked ? Icons.star : Icons.star_border,
              color: detail.tracked ? colors.gold : colors.textTertiary,
              size: 24,
            ),
          ),
          const SizedBox(width: 10),
        ],
        ItemIcon(
          imageUrl: detail.imageLink,
          fallbackIcon: Icons.home_work_outlined,
          size: 36,
          useGoldBackground: true,
        ),
      ],
    );
  }

  Widget buildContent({
    required BuildContext context,
    required WidgetRef ref,
    required HideoutDetailState state,
  }) {
    return state.when(
      initial: () => const SliverLoadingIndicator(),
      loading: () => const SliverLoadingIndicator(),
      error: (_) => SliverErrorMessage(
        message: tr.hideoutDetail.error.load,
        onRetry: () =>
            ref.read(hideoutDetailProvider(stationId).notifier).retry(),
      ),
      loaded: (detail) => buildLevels(detail: detail),
    );
  }

  Widget buildLevels({required HideoutDetailUiModel detail}) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: LevelCard(
              stationId: detail.stationId,
              model: detail.levels[i],
            ),
          ),
          childCount: detail.levels.length,
        ),
      ),
    );
  }
}
