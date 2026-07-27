import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_search_bar.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/keys/model/keys_list_ui_model.dart';
import 'package:darkoff/presentation/features/keys/notifiers/keys_list_notifier.dart';
import 'package:darkoff/presentation/features/keys/state/keys_list_state.dart';
import 'package:darkoff/presentation/features/keys/widgets/key_row.dart';
import 'package:darkoff/presentation/features/keys/widgets/key_sort_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class KeysPage extends ConsumerStatefulWidget {
  const KeysPage({super.key});

  @override
  ConsumerState<KeysPage> createState() => _KeysPageState();
}

class _KeysPageState extends ConsumerState<KeysPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final state = ref.watch(keysListProvider);
    final notifier = ref.read(keysListProvider.notifier);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: PageHeader(
                title: 'Keys',
                subtitle: 'Market prices & locations',
              ),
            ),
            SliverToBoxAdapter(
              child: AppSearchBar(
                controller: _searchController,
                onChanged: notifier.setSearch,
                hintText: 'Search keys...',
              ),
            ),
            ..._buildContent(state, notifier),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(KeysListState state, KeysListNotifier notifier) {
    return switch (state) {
      KeysListLoading() => [const SliverLoadingIndicator()],
      KeysListError() => [
        SliverErrorMessage(
          message: 'Failed to load keys',
          onRetry: notifier.refresh,
        ),
      ],
      KeysListLoaded(:final keys) => _buildLoaded(keys, notifier),
      _ => const [],
    };
  }

  List<Widget> _buildLoaded(KeysListUiModel keys, KeysListNotifier notifier) {
    return [
      SliverToBoxAdapter(
        child: KeySortBar(chips: keys.sortChips, onSelected: notifier.setSort),
      ),
      if (keys.isEmpty)
        const SliverEmptyMessage(message: 'No keys found')
      else
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: KeyRow(row: keys.rows[i]),
              ),
              childCount: keys.rows.length,
            ),
          ),
        ),
    ];
  }
}
