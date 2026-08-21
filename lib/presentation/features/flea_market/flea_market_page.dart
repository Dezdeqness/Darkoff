import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/flea_market/model/flea_item_ui_model.dart';
import 'package:darkoff/presentation/features/flea_market/notifiers/flea_category_notifier.dart';
import 'package:darkoff/presentation/features/flea_market/state/flea_category_state.dart';
import 'package:darkoff/presentation/features/flea_market/widgets/flea_item_row.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class FleaMarketPage extends ConsumerStatefulWidget {
  const FleaMarketPage({super.key});

  @override
  ConsumerState<FleaMarketPage> createState() => _FleaMarketPageState();
}

class _FleaMarketPageState extends ConsumerState<FleaMarketPage> {
  FleaCategory _category = FleaCategory.gainers;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final state = ref.watch(fleaCategoryProvider(_category));

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PageHeader(
                title: tr.fleaMarket.page.title,
                subtitle: tr.fleaMarket.page.subtitle,
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _CategoryTabsDelegate(
                background: colors.background,
                child: _CategoryTabs(
                  selected: _category,
                  onSelect: (c) => setState(() => _category = c),
                ),
              ),
            ),
            ...buildContent(state),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<Widget> buildContent(FleaCategoryState state) {
    return switch (state) {
      FleaCategoryLoading() => [
          const SliverLoadingIndicator(),
        ],
      FleaCategoryError(:final message) => [
          SliverErrorMessage(
            message: message,
            onRetry: () =>
                ref.read(fleaCategoryProvider(_category).notifier).refresh(),
          ),
        ],
      FleaCategoryLoaded(:final items) => [_buildList(items)],
      _ => const [],
    };
  }

  Widget _buildList(List<FleaItemUiModel> items) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      sliver: SliverList.builder(
        itemCount: items.length,
        itemBuilder: (ctx, i) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: FleaItemRow(
            item: items[i],
            rank: i + 1,
            onTap: () =>
                context.router.push(ItemDetailRoute(itemId: items[i].id)),
          ),
        ),
      ),
    );
  }
}

class _CategoryTabs extends StatelessWidget {
  const _CategoryTabs({required this.selected, required this.onSelect});

  final FleaCategory selected;
  final ValueChanged<FleaCategory> onSelect;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      (FleaCategory.gainers, Icons.trending_up, tr.fleaMarket.tab.gainers),
      (FleaCategory.losers, Icons.trending_down, tr.fleaMarket.tab.losers),
      (
        FleaCategory.expensive,
        Icons.monetization_on_outlined,
        tr.fleaMarket.tab.mostExpensive,
      ),
    ];

    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: tabs.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, i) {
          final (category, icon, label) = tabs[i];
          return Center(
            child: AppFilterChip(
              label: label,
              icon: icon,
              isActive: selected == category,
              onTap: () => onSelect(category),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryTabsDelegate extends SliverPersistentHeaderDelegate {
  _CategoryTabsDelegate({required this.child, required this.background});

  final Widget child;
  final Color background;

  static const double _extent = 60;

  @override
  double get minExtent => _extent;
  @override
  double get maxExtent => _extent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: background,
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: child,
    );
  }

  @override
  bool shouldRebuild(_CategoryTabsDelegate old) =>
      old.child != child || old.background != background;
}
