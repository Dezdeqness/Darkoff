import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/crafts/model/crafts_list_ui_model.dart';
import 'package:darkoff/presentation/features/crafts/notifiers/crafts_list_notifier.dart';
import 'package:darkoff/presentation/features/crafts/state/crafts_list_state.dart';
import 'package:darkoff/presentation/features/crafts/widgets/craft_card.dart';
import 'package:darkoff/presentation/features/crafts/widgets/craft_sort_toggle.dart';
import 'package:darkoff/presentation/features/crafts/widgets/craft_station_filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CraftsPage extends ConsumerWidget {
  const CraftsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(craftsListProvider);
    final notifier = ref.read(craftsListProvider.notifier);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PageHeader(
                title: tr.crafts.page.title,
                subtitle: tr.crafts.page.subtitle,
              ),
            ),
            ..._buildContent(state, notifier),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(
    CraftsListState state,
    CraftsListNotifier notifier,
  ) {
    return switch (state) {
      CraftsListLoading() => [const SliverLoadingIndicator()],
      CraftsListError() => [
        SliverErrorMessage(
          message: tr.crafts.error.load,
          onRetry: notifier.refresh,
        ),
      ],
      CraftsListLoaded(:final crafts) => _buildLoaded(crafts, notifier),
      _ => const [],
    };
  }

  List<Widget> _buildLoaded(
    CraftsListUiModel crafts,
    CraftsListNotifier notifier,
  ) {
    return [
      SliverToBoxAdapter(
        child: CraftStationFilter(
          stations: crafts.stations,
          onSelected: notifier.selectStation,
        ),
      ),
      SliverToBoxAdapter(
        child: CraftSortToggle(
          label: crafts.sortLabel,
          onToggle: notifier.toggleSort,
        ),
      ),
      if (crafts.isEmpty)
        SliverEmptyMessage(message: tr.crafts.emptyState.notFound)
      else
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, i) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CraftCard(craft: crafts.rows[i]),
              ),
              childCount: crafts.rows.length,
            ),
          ),
        ),
    ];
  }
}
