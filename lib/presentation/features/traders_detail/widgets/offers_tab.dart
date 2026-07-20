import 'package:darkoff/presentation/features/traders_detail/notifiers/trader_offers_notifier.dart';
import 'package:darkoff/presentation/features/traders_detail/state/trader_offers_state.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/offer_card.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/trade_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OffersTab extends ConsumerWidget {
  const OffersTab({
    super.key,
    required this.traderId,
    required this.onOpenItem,
  });

  final String traderId;
  final void Function(String itemId) onOpenItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(traderOffersProvider(traderId));

    return switch (state) {
      TraderOffersLoaded(:final offers, :final levels, :final selectedLevel) =>
        TradeScrollView(
          levels: levels,
          selectedLevel: selectedLevel,
          onSelectLevel: (l) =>
              ref.read(traderOffersProvider(traderId).notifier).selectLevel(l),
          emptyLabel: 'No offers for this level',
          itemCount: offers.length,
          itemBuilder: (i) => OfferCard(
            offer: offers[i],
            onTap: () => onOpenItem(offers[i].itemId),
          ),
        ),
      _ => const SizedBox.shrink(),
    };
  }
}
