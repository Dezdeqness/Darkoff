import 'package:darkoff/core/theme/extension/theme_extensions.dart';
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
        child: Column(
          children: [
            _TradesTabBar(
              offersCount: model.offers.length,
              bartersCount: model.barters.length,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  OffersTab(traderId: model.id, onOpenItem: onOpenItem),
                  BartersTab(traderId: model.id, onOpenItem: onOpenItem),
                ],
              ),
            ),
          ],
        ),
      );
    }
    if (hasOffers) {
      return OffersTab(traderId: model.id, onOpenItem: onOpenItem);
    }
    if (hasBarters) {
      return BartersTab(traderId: model.id, onOpenItem: onOpenItem);
    }
    return const SizedBox.shrink();
  }
}

class _TradesTabBar extends StatelessWidget {
  const _TradesTabBar({required this.offersCount, required this.bartersCount});

  final int offersCount;
  final int bartersCount;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surface,
        border: colors.inactiveChipBorder,
        borderRadius: BorderRadius.circular(22),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        indicator: BoxDecoration(
          color: colors.goldSubtle,
          border: colors.activeChipBorder,
          borderRadius: BorderRadius.circular(18),
        ),
        labelColor: colors.gold,
        unselectedLabelColor: colors.textSecondary,
        labelStyle: typo.labelMedium,
        unselectedLabelStyle: typo.labelMedium,
        tabs: [
          Tab(height: 36, text: 'Offers $offersCount'),
          Tab(height: 36, text: 'Barters $bartersCount'),
        ],
      ),
    );
  }
}
