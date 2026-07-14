import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_error_view.dart';
import 'package:darkoff/core/widgets/item_icon.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/presentation/features/traders/widgets/trader_reset_label.dart';
import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:darkoff/presentation/features/traders_detail/notifiers/trader_detail_notifier.dart';
import 'package:darkoff/presentation/features/traders_detail/state/trader_detail_state.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/trader_trades_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TradersDetailPage extends ConsumerWidget {
  const TradersDetailPage({
    super.key,
    @PathParam('traderId') required this.traderId,
  });

  final String traderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(traderDetailProvider(traderId));

    final model = state.maybeWhen(loaded: (model) => model, orElse: () => null);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(context, model),
            Expanded(child: buildContent(context, ref, state)),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context, TraderDetailUiModel? model) {
    if (model == null) return const PageHeader(title: 'Trader');

    return PageHeader.subtitleContent(
      title: model.name,
      subtitle: TraderResetLabel(
        resetTime: model.resetTime,
        style: context.typographyTheme.bodySmall.copyWith(
          color: context.colorTheme.textSecondary,
        ),
      ),
      trailing: ItemIcon(
        imageUrl: model.imageLink,
        fallbackIcon: Icons.person_outline,
        size: 36,
        useGoldBackground: true,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildContent(BuildContext context, WidgetRef ref, TraderDetailState state) {
    return switch (state) {
      TraderDetailLoading() => const Center(child: CircularProgressIndicator()),
      TraderDetailError() => AppErrorView(
        message: 'Failed to load trader',
        onRetry: () =>
            ref.read(traderDetailProvider(traderId).notifier).refresh(),
      ),
      TraderDetailLoaded(:final model) => TraderTradesView(
        model: model,
        onOpenItem: (itemId) =>
            context.router.push(ItemDetailRoute(itemId: itemId)),
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
