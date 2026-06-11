import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_empty_view.dart';
import 'package:darkoff/core/widgets/app_error_view.dart';
import 'package:darkoff/core/widgets/app_search_bar.dart';
import 'package:darkoff/presentation/features/items/notifiers/items_search_notifier.dart';
import 'package:darkoff/presentation/features/items/state/items_search_state.dart';
import 'package:darkoff/presentation/features/items/widgets/item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ItemsSearchPage extends ConsumerStatefulWidget {
  const ItemsSearchPage({super.key});

  @override
  ConsumerState<ItemsSearchPage> createState() => _ItemsSearchPageState();
}

class _ItemsSearchPageState extends ConsumerState<ItemsSearchPage> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(itemsSearchProvider);
    final colors = context.colorTheme;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Hero(
                tag: 'items-search',
                child: AppSearchBar(
                  hintText: 'Search items...',
                  controller: _textController,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  onChanged: (query) {
                    ref.read(itemsSearchProvider.notifier).onQueryChanged(query);
                  },
                  autofocus: true,
                ),
              ),
            ),
            buildItemsContent(context: context, state: state),
          ],
        ),
      ),
    );
  }

  Widget buildItemsContent({
    required BuildContext context,
    required ItemsSearchState state,
  }) {
    final colors = context.colorTheme;

    return state.when(
      initial: () => SliverToBoxAdapter(child: SizedBox.shrink()),
      loading: () => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator(color: colors.gold)),
        ),
      ),
      empty: () => SliverToBoxAdapter(
        child: AppEmptyView(
          message: 'No items found',
          icon: Icons.inventory_2_outlined,
        ),
      ),
      loaded: (items, hasMore, isLoadingMore, isRefreshing) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, i) => ItemCard(item: items[i]),
          childCount: items.length,
        ),
      ),
      error: (msg) => SliverToBoxAdapter(
        child: AppErrorView(
          message: msg,
          onRetry: () => ref.read(itemsSearchProvider.notifier).refresh(),
        ),
      ),
    );
  }
}
