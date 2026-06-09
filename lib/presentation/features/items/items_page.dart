import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_empty_view.dart';
import 'package:darkoff/core/widgets/app_error_view.dart';
import 'package:darkoff/core/widgets/app_filter_chip.dart';
import 'package:darkoff/core/widgets/app_search_bar.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/presentation/features/items/notifiers/categories_notifier.dart';
import 'package:darkoff/presentation/features/items/notifiers/items_notifier.dart';
import 'package:darkoff/presentation/features/items/state/items_state.dart';
import 'package:darkoff/presentation/features/items/widgets/item_card.dart';
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
  final _searchController = TextEditingController();

  Widget buildSearchBar({required BuildContext context}) {
    return SearchAnchor(
      isFullScreen: true,
      builder: (context, controller) {
        return AppSearchBar(
          hintText: 'Search items...',
          onChanged: (v) => setState(() {}),
          controller: _searchController,
          onTap: () => controller.openView(),
          enabled: controller.isOpen,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        );
      },
      suggestionsBuilder: (context, controller) {
        return [
          ListTile(
            title: Text('Flutter'),
            onTap: () {
              controller.closeView('Flutter');
            },
          ),
        ];
      },
    );
  }

  Widget buildCategoryChips({required BuildContext context}) {
    final categoriesState = ref.watch(categoriesProvider);
    return AppFilterChipRow(
      items: categoriesState.categories
          .map((item) => ChipItem(item.label))
          .toList(),
      selectedIndex: categoriesState.selectedIndex,
      onSelected: (int value) {
        setState(
          () => ref.read(categoriesProvider.notifier).selectCategory(value),
        );
      },
    );
  }

  Widget buildItemsContent({
    required BuildContext context,
    required ItemsState state,
  }) {
    final colors = context.colorTheme;

    return state.when(
      initial: () => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator(color: colors.gold)),
        ),
      ),
      loading: () => SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Center(child: CircularProgressIndicator(color: colors.gold)),
        ),
      ),
      empty: () => const SliverToBoxAdapter(
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
          onRetry: () => ref.read(itemsProvider.notifier).refresh(),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final state = ref.watch(itemsProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: RefreshIndicator(
          color: colors.gold,
          backgroundColor: colors.surface,
          onRefresh: () => ref.read(itemsProvider.notifier).refresh(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: PageHeader(
                  title: 'Items',
                  subtitle: 'Browse all Tarkov items',
                  showBack: false,
                ),
              ),
              SliverToBoxAdapter(child: buildSearchBar(context: context)),
              SliverToBoxAdapter(child: buildCategoryChips(context: context)),
              buildItemsContent(context: context, state: state),
            ],
          ),
        ),
      ),
    );
  }
}
