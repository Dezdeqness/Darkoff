import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/traders_detail/notifiers/trader_barters_notifier.dart';
import 'package:darkoff/presentation/features/traders_detail/state/trader_barters_state.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/barter_card.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/trade_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BartersTab extends ConsumerWidget {
  const BartersTab({
    super.key,
    required this.traderId,
    required this.onOpenItem,
  });

  final String traderId;
  final void Function(String itemId) onOpenItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(traderBartersProvider(traderId));

    return switch (state) {
      TraderBartersLoaded(:final barters, :final levels, :final selectedLevel) =>
        TradeScrollView(
          levels: levels,
          selectedLevel: selectedLevel,
          onSelectLevel: (l) =>
              ref.read(traderBartersProvider(traderId).notifier).selectLevel(l),
          emptyLabel: tr.traderDetail.tab.noBarters,
          itemCount: barters.length,
          itemBuilder: (i) => BarterCard(
            barter: barters[i],
            onOpenItem: onOpenItem,
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
