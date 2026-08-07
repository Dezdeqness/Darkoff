import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_search_bar.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
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
                  hintText: tr.items.search.hint,
                  controller: _textController,
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
    return state.when(
      initial: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
      loading: () => const SliverLoadingIndicator(),
      empty: () => SliverEmptyMessage(message: tr.items.emptyState.notFound),
      loaded: (items, hasMore, isLoadingMore, isRefreshing) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, i) => ItemCard(item: items[i]),
          childCount: items.length,
        ),
      ),
      error: (msg) => SliverErrorMessage(
        message: msg,
        onRetry: () => ref.read(itemsSearchProvider.notifier).refresh(),
      ),
    );
  }
}
