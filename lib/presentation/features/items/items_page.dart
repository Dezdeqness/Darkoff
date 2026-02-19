import 'package:auto_route/auto_route.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/item_type.dart';
import 'package:darkoff/presentation/features/items/model/item_ui_model.dart';
import 'package:darkoff/presentation/features/items/notifiers/items_notifier.dart';
import 'package:darkoff/presentation/features/items/state/items_state.dart';
import 'package:darkoff/presentation/features/items/widgets/item_card.dart';
import 'package:darkoff/presentation/features/items/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ItemsPage extends ConsumerStatefulWidget {
  const ItemsPage({super.key, this.types = const []});

  final List<ItemType> types;

  @override
  ConsumerState<ItemsPage> createState() => _ItemsPageState();
}

class _ItemsPageState extends ConsumerState<ItemsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(itemsProvider.call(widget.types).notifier).loadMoreItems();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(itemsProvider.call(widget.types));

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () =>
              ref.read(itemsProvider.call(widget.types).notifier).refresh(),
          child: state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            empty: () => _buildEmptyState(),
            loaded: (items, hasMore, isLoadingMore, isRefreshing) =>
                _buildItemsList(items, hasMore, isLoadingMore, isRefreshing),
            error: (message) => _buildErrorState(message),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No items found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            'Error loading items',
            style: const TextStyle(fontSize: 18, color: Colors.red),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                ref.read(itemsProvider.call(widget.types).notifier).refresh(),
            child: const Text('Retry'),
          ),
        ],
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
      controller: _scrollController,
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
