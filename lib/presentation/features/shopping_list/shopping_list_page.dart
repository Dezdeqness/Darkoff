import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/shopping_list/model/shopping_list_ui_model.dart';
import 'package:darkoff/presentation/features/shopping_list/notifiers/shopping_list_notifier.dart';
import 'package:darkoff/presentation/features/shopping_list/state/shopping_list_state.dart';
import 'package:darkoff/presentation/features/shopping_list/widgets/shopping_list_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ShoppingListPage extends ConsumerWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(shoppingListProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PageHeader(
                title: tr.shoppingList.page.title,
                subtitle: tr.shoppingList.page.subtitle,
              ),
            ),
            buildContent(state),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  Widget buildContent(ShoppingListState state) {
    return state.when(
      loading: () => const SliverLoadingIndicator(),
      empty: () => SliverEmptyMessage(
        message: tr.shoppingList.empty,
      ),
      loaded: buildList,
    );
  }

  Widget buildList(ShoppingListUiModel model) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: ShoppingListSummaryCard(model: model)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => ShoppingListRow(model: model.rows[i]),
              childCount: model.rows.length,
            ),
          ),
        ),
      ],
    );
  }
}
