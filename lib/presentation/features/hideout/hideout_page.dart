import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/sliver_states.dart';
import 'package:darkoff/presentation/features/hideout/model/hideout_list_ui_model.dart';
import 'package:darkoff/presentation/features/hideout/notifiers/hideout_list_notifier.dart';
import 'package:darkoff/presentation/features/hideout/state/hideout_list_state.dart';
import 'package:darkoff/presentation/features/hideout/widgets/hideout_summary_card.dart';
import 'package:darkoff/presentation/features/hideout/widgets/shopping_entry_card.dart';
import 'package:darkoff/presentation/features/hideout/widgets/station_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class HideoutPage extends ConsumerWidget {
  const HideoutPage({super.key});

  Widget buildContent({
    required BuildContext context,
    required WidgetRef ref,
    required HideoutListState state,
  }) {
    return state.when(
      loading: () => const SliverLoadingIndicator(),
      empty: () => SliverEmptyMessage(message: tr.hideout.emptyState.noStations),
      loaded: (model) => buildList(context, model),
      error: (_) => SliverErrorMessage(
        message: tr.hideout.error.load,
        onRetry: () => ref.read(hideoutListProvider.notifier).refresh(),
      ),
    );
  }

  Widget buildList(BuildContext context, HideoutListUiModel model) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(child: HideoutSummaryCard(model: model.summary)),
        SliverToBoxAdapter(
          child: ShoppingEntryCard(
            model: model.shoppingEntry,
            onTap: () => context.router.push(ShoppingListRoute()),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
                  (ctx, i) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: StationCard(model: model.stations[i]),
              ),
              childCount: model.stations.length,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(hideoutListProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PageHeader(
                title: tr.hideout.page.title,
                subtitle: tr.hideout.page.subtitle,
              ),
            ),
            buildContent(context: context, ref: ref, state: state),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

}
