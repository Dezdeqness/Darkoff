import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:darkoff/presentation/features/home/home_keys.dart';
import 'package:darkoff/presentation/features/home/notifiers/market_snapshot_notifier.dart';
import 'package:darkoff/presentation/features/home/notifiers/price_changes_notifier.dart';
import 'package:darkoff/presentation/features/home/notifiers/server_status_notifier.dart';
import 'package:darkoff/presentation/features/home/state/market_snapshot_state.dart';
import 'package:darkoff/presentation/features/home/state/price_changes_state.dart';
import 'package:darkoff/presentation/features/home/widgets/home_loading.dart';
import 'package:darkoff/presentation/features/home/widgets/home_placeholder_widget.dart';
import 'package:darkoff/presentation/features/home/widgets/home_section.dart';
import 'package:darkoff/presentation/features/home/widgets/market_overview_card.dart';
import 'package:darkoff/presentation/features/home/widgets/price_change_row.dart';
import 'package:darkoff/presentation/features/home/widgets/server_status_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  Widget buildHomeHeader(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'DARKOFF',
              style: typo.titleLarge.copyWith(
                color: colors.textPrimary,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMarketSection(BuildContext context, WidgetRef ref) {
    const marketSectionHeight = 202.0;

    final loading = HomeLoading(
      key: HomeKeys.marketLoading,
      height: marketSectionHeight,
    );

    final child = ref
        .watch(marketSnapshotProvider)
        .when(
          initial: () => loading,
          loading: () => loading,
          empty: () => const HomePlaceholderWidget(
            key: HomeKeys.marketEmpty,
            height: marketSectionHeight,
            message: 'No market data',
          ),
          loaded: (items) => GridView.builder(
            key: HomeKeys.marketLoaded,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              mainAxisExtent: 96,
            ),
            itemCount: items.length,
            itemBuilder: (context, i) => MarketOverviewCard(item: items[i]),
          ),
          error: (_) => HomePlaceholderWidget(
            key: HomeKeys.marketError,
            height: marketSectionHeight,
            message: 'Failed to load market overview',
            onRetry: () => ref.read(marketSnapshotProvider.notifier).refresh(),
          ),
        );

    return HomeSection(title: 'Market Overview', child: child);
  }

  Widget buildPriceChanges(BuildContext context, WidgetRef ref) {
    const priceSectionHeight = 340.0;

    const loading = HomeLoading(
      key: HomeKeys.priceChangesLoading,
      height: priceSectionHeight,
    );

    final child = ref
        .watch(priceChangesProvider)
        .when(
      initial: () => loading,
      loading: () => loading,
      empty: () => HomePlaceholderWidget(
        key: HomeKeys.priceChangesEmpty,
        height: priceSectionHeight,
        message: 'No price data',
      ),
      loaded: (items) => AppCard(
        key: HomeKeys.priceChangesLoaded,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            for (var i = 0; i < items.length; i++)
              PriceChangeRow(item: items[i], isLast: i == items.length - 1),
          ],
        ),
      ),
      error: (_) => HomePlaceholderWidget(
        key: HomeKeys.priceChangesError,
        height: priceSectionHeight,
        message: 'Failed to load market data',
        onRetry: () => ref.read(priceChangesProvider.notifier).refresh(),
      ),
    );

    return HomeSection(title: 'Price Changes (24h)', child: child);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: buildHomeHeader(context)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              sliver: SliverToBoxAdapter(
                child: ServerStatusCard(
                  state: ref.watch(serverStatusProvider),
                  onRefresh: () =>
                      ref.read(serverStatusProvider.notifier).refresh(),
                ),
              ),
            ),
            buildMarketSection(context, ref),
            buildPriceChanges(context, ref),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}
