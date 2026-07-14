import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/offer_card.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/trade_scroll_view.dart';
import 'package:flutter/material.dart';

class OffersTab extends StatefulWidget {
  const OffersTab({
    super.key,
    required this.model,
    required this.showTabBar,
    required this.onOpenItem,
  });

  final TraderDetailUiModel model;
  final bool showTabBar;
  final void Function(String itemId) onOpenItem;

  @override
  State<OffersTab> createState() => _OffersTabState();
}

class _OffersTabState extends State<OffersTab> {
  int? _level;

  List<int> get _levels {
    final set = <int>{};
    for (final o in widget.model.offers) {
      if (o.minTraderLevel != null) set.add(o.minTraderLevel!);
    }
    return set.toList()..sort();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _level == null
        ? widget.model.offers
        : widget.model.offers
            .where((o) => o.minTraderLevel == _level)
            .toList();

    return TradeScrollView(
      offersCount: widget.model.offers.length,
      bartersCount: widget.model.barters.length,
      showTabBar: widget.showTabBar,
      levels: _levels,
      selectedLevel: _level,
      onSelectLevel: (l) => setState(() => _level = l),
      emptyLabel: 'No offers for this level',
      itemCount: filtered.length,
      itemBuilder: (i) => OfferCard(
        offer: filtered[i],
        onTap: () => widget.onOpenItem(filtered[i].itemId),
      ),
    );
  }
}
