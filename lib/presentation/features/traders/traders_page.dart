import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/traders/notifiers/traders_notifier.dart';
import 'package:darkoff/presentation/features/traders/state/traders_state.dart';
import 'package:darkoff/presentation/features/traders/widgets/trader_card.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TradersPage extends ConsumerWidget {
  const TradersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(tradersProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: PageHeader(
                title: 'Traders',
                subtitle: 'Offers, barters & reset times',
              ),
            ),
            ...buildContent(context, ref, state),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<Widget> buildContent(
      BuildContext context, WidgetRef ref, TradersState state) {
    return switch (state) {
      TradersInitial() || TradersLoading() => [
          const SliverLoadingIndicator(),
        ],
      TradersError() => [
          SliverErrorMessage(
            message: 'Failed to load traders',
            onRetry: () => ref.read(tradersProvider.notifier).refresh(),
          ),
        ],
      TradersLoaded(:final traders) => [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TraderCard(trader: traders[i]),
                ),
                childCount: traders.length,
              ),
            ),
          ),
        ],
      _ => [],
    };
  }
}
