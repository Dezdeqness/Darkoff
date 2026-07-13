import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/traders/notifiers/traders_list_notifier.dart';
import 'package:darkoff/presentation/features/traders/state/traders_list_state.dart';
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
    final state = ref.watch(tradersListProvider);

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
      BuildContext context, WidgetRef ref, TradersListState state) {
    return switch (state) {
      TradersListLoading() => [
          const SliverLoadingIndicator(),
        ],
      TradersListError() => [
          SliverErrorMessage(
            message: 'Failed to load traders',
            onRetry: () => ref.read(tradersListProvider.notifier).refresh(),
          ),
        ],
      TradersListLoaded(:final traders) => [
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (ctx, i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: TraderCard(model: traders[i]),
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
