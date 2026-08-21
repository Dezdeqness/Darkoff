import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/bosses/model/boss_list_ui_model.dart';
import 'package:darkoff/presentation/features/bosses/notifiers/bosses_list_notifier.dart';
import 'package:darkoff/presentation/features/bosses/state/bosses_list_state.dart';
import 'package:darkoff/presentation/features/bosses/widgets/boss_card.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class BossesPage extends ConsumerWidget {
  const BossesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(bossesListProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PageHeader(
                title: tr.bosses.page.title,
                subtitle: tr.bosses.page.subtitle,
              ),
            ),
            ..._buildContent(context, ref, state),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent(
    BuildContext context,
    WidgetRef ref,
    BossesListState state,
  ) {
    return switch (state) {
      BossesListLoading() => [const SliverLoadingIndicator()],
      BossesListError() => [
        SliverErrorMessage(
          message: tr.bosses.error.load,
          onRetry: () => ref.read(bossesListProvider.notifier).refresh(),
        ),
      ],
      BossesListLoaded(:final bosses) => _buildList(bosses),
      _ => [],
    };
  }

  List<Widget> _buildList(List<BossListItemUiModel> bosses) {
    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: BossCard(boss: bosses[i]),
            ),
            childCount: bosses.length,
          ),
        ),
      ),
    ];
  }
}
