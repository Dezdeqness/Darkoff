import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/barters_tab.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/offers_tab.dart';
import 'package:flutter/material.dart';

class TraderTradesView extends StatelessWidget {
  const TraderTradesView({
    super.key,
    required this.model,
    required this.onOpenItem,
  });

  final TraderDetailUiModel model;
  final void Function(String itemId) onOpenItem;

  @override
  Widget build(BuildContext context) {
    final hasOffers = model.offers.isNotEmpty;
    final hasBarters = model.barters.isNotEmpty;

    if (hasOffers && hasBarters) {
      return DefaultTabController(
        length: 2,
        child: TabBarView(
          children: [
            OffersTab(model: model, showTabBar: true, onOpenItem: onOpenItem),
            BartersTab(model: model, showTabBar: true, onOpenItem: onOpenItem),
          ],
        ),
      );
    }
    if (hasOffers) {
      return OffersTab(model: model, showTabBar: false, onOpenItem: onOpenItem);
    }
    if (hasBarters) {
      return BartersTab(model: model, showTabBar: false, onOpenItem: onOpenItem);
    }
    return const SizedBox.shrink();
  }
}
