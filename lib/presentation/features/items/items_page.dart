import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/widgets/app_empty_view.dart';
import 'package:darkoff/core/widgets/app_error_view.dart';
import 'package:darkoff/presentation/features/items/model/item_ui_model.dart';
import 'package:darkoff/presentation/features/items/notifiers/items_notifier.dart';
import 'package:darkoff/presentation/features/items/state/items_state.dart';
import 'package:darkoff/presentation/features/items/widgets/item_card.dart';
import 'package:darkoff/presentation/features/items/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ItemsPage extends ConsumerStatefulWidget {
  const ItemsPage({super.key, this.categoryNames = const []});

  final List<String> categoryNames;

  @override
  ConsumerState<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends ConsumerState<ItemsPage> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(itemsProvider.call(widget.categoryNames));

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(itemsProvider.call(widget.categoryNames).notifier).refresh(),
          child: state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            empty: () => const AppEmptyView(
              message: 'No items found',
              icon: Icons.inventory_2_outlined,
            ),
            loaded: (items, hasMore, isLoadingMore, isRefreshing) =>
                _buildItemsList(items, hasMore, isLoadingMore, isRefreshing),
            error: (message) => AppErrorView(
              message: message,
              onRetry: () =>
                  ref.read(itemsProvider.call(widget.categoryNames).notifier).refresh(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItemsList(
    List<ItemUiModel> items,
    bool hasMore,
    bool isLoadingMore,
    bool isRefreshing,
  ) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Items'),
          floating: true,
          snap: true,
          pinned: false,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final item = items[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ItemCard(item: item),
              );
            }, childCount: items.length),
          ),
        ),
        if (isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: LoadingIndicator()),
            ),
          ),
      ],
    );
  }
}
