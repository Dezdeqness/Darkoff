import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/barter_card.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/trade_scroll_view.dart';
import 'package:flutter/material.dart';

class BartersTab extends StatefulWidget {
  const BartersTab({
    super.key,
    required this.model,
    required this.showTabBar,
    required this.onOpenItem,
  });

  final TraderDetailUiModel model;
  final bool showTabBar;
  final void Function(String itemId) onOpenItem;

  @override
  State<BartersTab> createState() => _BartersTabState();
}

class _BartersTabState extends State<BartersTab> {
  int? _level;

  List<int> get _levels {
    final set = <int>{for (final b in widget.model.barters) b.level};
    return set.toList()..sort();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _level == null
        ? widget.model.barters
        : widget.model.barters.where((b) => b.level == _level).toList();

    return TradeScrollView(
      offersCount: widget.model.offers.length,
      bartersCount: widget.model.barters.length,
      showTabBar: widget.showTabBar,
      levels: _levels,
      selectedLevel: _level,
      onSelectLevel: (l) => setState(() => _level = l),
      emptyLabel: 'No barters for this level',
      itemCount: filtered.length,
      itemBuilder: (i) => BarterCard(
        barter: filtered[i],
        onOpenItem: widget.onOpenItem,
      ),
    );
  }
}
