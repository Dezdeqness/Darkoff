import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/barters/model/barters_list_ui_model.dart';
import 'package:darkoff/presentation/features/barters/notifiers/barters_list_notifier.dart';
import 'package:darkoff/presentation/features/barters/state/barters_list_state.dart';
import 'package:darkoff/presentation/features/barters/widgets/barter_card.dart';
import 'package:darkoff/presentation/features/barters/widgets/barter_sort_toggle.dart';
import 'package:darkoff/presentation/features/barters/widgets/barter_trader_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class BartersPage extends ConsumerWidget {
  const BartersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(bartersListProvider);
    final notifier = ref.read(bartersListProvider.notifier);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: PageHeader(
                title: 'Barters',
                subtitle: 'Trader barter trades & profit',
              ),
            ),
            ..._buildContent(state, notifier),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(
    BartersListState state,
    BartersListNotifier notifier,
  ) {
    return switch (state) {
      BartersListLoading() => [const SliverLoadingIndicator()],
      BartersListError() => [
        SliverErrorMessage(
          message: 'Failed to load barters',
          onRetry: notifier.refresh,
        ),
      ],
      BartersListLoaded(:final barters) => _buildLoaded(barters, notifier),
      _ => const [],
    };
  }

  List<Widget> _buildLoaded(
    BartersListUiModel barters,
    BartersListNotifier notifier,
  ) {
    return [
      SliverToBoxAdapter(
        child: BarterTraderFilter(
          traders: barters.traders,
          onSelected: notifier.selectTrader,
        ),
      ),
      SliverToBoxAdapter(
        child: BarterSortToggle(
          label: barters.sortLabel,
          onToggle: notifier.toggleSort,
        ),
      ),
      if (barters.isEmpty)
        const SliverEmptyMessage(message: 'No barters found')
      else
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: BarterCard(barter: barters.rows[i]),
              ),
              childCount: barters.rows.length,
            ),
          ),
        ),
    ];
  }
}
