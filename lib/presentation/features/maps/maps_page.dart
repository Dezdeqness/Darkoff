import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/maps/notifiers/maps_notifier.dart';
import 'package:darkoff/presentation/features/maps/state/maps_state.dart';
import 'package:darkoff/presentation/features/maps/widgets/map_card.dart';
import 'package:darkoff/presentation/features/maps/widgets/map_section_label.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MapsPage extends ConsumerWidget {
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(mapsProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader(context)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                child: MapSectionLabel(tr.maps.section.all),
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
    MapsState state,
  ) {
    return switch (state) {
      MapsInitial() || MapsLoading() => [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
      MapsEmpty() => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                tr.maps.emptyState.notFound,
                style: const TextStyle(color: Color(0xFF888888)),
              ),
            ),
          ),
        ),
      ],
      MapsError() => [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                Text(
                  tr.maps.error.load,
                  style: TextStyle(color: context.colorTheme.loss),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => ref.read(mapsProvider.notifier).refresh(),
                  child: Text(tr.common.action.retry),
                ),
              ],
            ),
          ),
        ),
      ],
      MapsLoaded(:final maps) => [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (ctx, i) => MapCard(map: maps[i]),
            childCount: maps.length,
          ),
        ),
      ],
      _ => [],
    };
  }

  Widget _buildHeader(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tr.maps.page.title,
            style: typo.titleLarge.copyWith(
              color: colors.textPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tr.maps.page.subtitle,
            style: typo.bodySmall.copyWith(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }
}
