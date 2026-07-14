import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/trader_level_filter.dart';
import 'package:flutter/material.dart';

const double _kTabBarExtent = 72;
const double _kFilterExtent = 52;

class TradeScrollView extends StatelessWidget {
  const TradeScrollView({
    super.key,
    required this.offersCount,
    required this.bartersCount,
    required this.showTabBar,
    required this.levels,
    required this.selectedLevel,
    required this.onSelectLevel,
    required this.emptyLabel,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int offersCount;
  final int bartersCount;
  final bool showTabBar;
  final List<int> levels;
  final int? selectedLevel;
  final ValueChanged<int?> onSelectLevel;
  final String emptyLabel;
  final int itemCount;
  final Widget Function(int index) itemBuilder;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return CustomScrollView(
      slivers: [
        if (showTabBar)
          SliverAppBar(
            primary: false,
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            snap: true,
            elevation: 0,
            backgroundColor: colors.background,
            toolbarHeight: 0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(_kTabBarExtent),
              child: _TradesTabBar(
                offersCount: offersCount,
                bartersCount: bartersCount,
              ),
            ),
          ),
        if (levels.length >= 2)
          SliverPersistentHeader(
            pinned: true,
            delegate: _FilterHeaderDelegate(
              background: colors.background,
              child: TraderLevelFilter(
                levels: levels,
                selected: selectedLevel,
                onSelect: onSelectLevel,
              ),
            ),
          ),
        if (itemCount == 0)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Text(
                emptyLabel,
                style: typo.paragraphSmall.copyWith(color: colors.textTertiary),
              ),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            sliver: SliverList.builder(
              itemCount: itemCount,
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: itemBuilder(i),
              ),
            ),
          ),
      ],
    );
  }
}

class _FilterHeaderDelegate extends SliverPersistentHeaderDelegate {
  _FilterHeaderDelegate({required this.child, required this.background});

  final Widget child;
  final Color background;

  @override
  double get minExtent => _kFilterExtent;
  @override
  double get maxExtent => _kFilterExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: background, child: child);
  }

  @override
  bool shouldRebuild(_FilterHeaderDelegate old) =>
      old.child != child || old.background != background;
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
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
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
