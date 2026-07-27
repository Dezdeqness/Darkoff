import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_search_bar.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/ammo/model/ammo_list_ui_model.dart';
import 'package:darkoff/presentation/features/ammo/notifiers/ammo_list_notifier.dart';
import 'package:darkoff/presentation/features/ammo/state/ammo_list_state.dart';
import 'package:darkoff/presentation/features/ammo/widgets/ammo_caliber_filter.dart';
import 'package:darkoff/presentation/features/ammo/widgets/ammo_group_card.dart';
import 'package:darkoff/presentation/features/ammo/widgets/ammo_row.dart';
import 'package:darkoff/presentation/features/ammo/widgets/ammo_sort_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class AmmoPage extends ConsumerStatefulWidget {
  const AmmoPage({super.key});

  @override
  ConsumerState<AmmoPage> createState() => _AmmoPageState();
}

class _AmmoPageState extends ConsumerState<AmmoPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final state = ref.watch(ammoListProvider);
    final notifier = ref.read(ammoListProvider.notifier);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: PageHeader(
                title: 'Ammo Chart',
                subtitle: 'Damage & penetration reference',
              ),
            ),
            SliverToBoxAdapter(
              child: AppSearchBar(
                controller: _searchController,
                onChanged: notifier.setSearch,
                hintText: 'Search ammo...',
              ),
            ),
            ..._buildContent(state, notifier),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(AmmoListState state, AmmoListNotifier notifier) {
    return switch (state) {
      AmmoListLoading() => [const SliverLoadingIndicator()],
      AmmoListError() => [
        SliverErrorMessage(
          message: 'Failed to load ammo data',
          onRetry: notifier.refresh,
        ),
      ],
      AmmoListLoaded(:final ammo) => _buildLoaded(ammo, notifier),
      _ => const [],
    };
  }

  List<Widget> _buildLoaded(AmmoListUiModel ammo, AmmoListNotifier notifier) {
    return [
      SliverToBoxAdapter(
        child: AmmoCaliberFilter(
          calibers: ammo.calibers,
          selected: ammo.selectedCaliber,
          onSelected: notifier.selectCaliber,
        ),
      ),
      SliverToBoxAdapter(
        child: AmmoSortToggle(
          label: ammo.sortLabel,
          onToggle: notifier.toggleSort,
        ),
      ),
      if (ammo.isEmpty)
        const SliverEmptyMessage(message: 'No ammo found')
      else if (ammo.grouped)
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => AmmoGroupCard(group: ammo.groups[i]),
            childCount: ammo.groups.length,
          ),
        )
      else
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => AmmoRow(row: ammo.rows[i], showDivider: true),
            childCount: ammo.rows.length,
          ),
        ),
    ];
  }
}
