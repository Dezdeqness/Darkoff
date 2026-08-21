import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/maps/notifiers/map_detail_notifier.dart';
import 'package:darkoff/presentation/features/maps/state/map_detail_state.dart';
import 'package:darkoff/presentation/features/maps/widgets/map_detail_view.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MapDetailPage extends ConsumerWidget {
  const MapDetailPage({super.key, @PathParam('mapId') required this.mapId});

  final String mapId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(mapDetailProvider(mapId));

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _header(state)),
            ..._buildContent(state, ref),
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }

  Widget _header(MapDetailState state) => PageHeader(
    title: switch (state) {
      MapDetailLoaded(:final map) => map.name,
      _ => tr.maps.detail.fallbackTitle,
    },
    subtitle: tr.maps.detail.subtitle,
  );

  List<Widget> _buildContent(MapDetailState state, WidgetRef ref) {
    return switch (state) {
      MapDetailLoading() => [const SliverLoadingIndicator()],
      MapDetailError(:final message) => [
        SliverErrorMessage(
          message: message,
          onRetry: () => ref.read(mapDetailProvider(mapId).notifier).refresh(),
        ),
      ],
      MapDetailLoaded(:final map) => [
        SliverToBoxAdapter(child: MapDetailView(map: map)),
      ],
      _ => const [],
    };
  }
}
