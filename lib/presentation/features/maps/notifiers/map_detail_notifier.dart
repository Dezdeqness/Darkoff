import 'package:darkoff/presentation/features/maps/model/map_ui_model.dart';
import 'package:darkoff/presentation/features/maps/notifiers/maps_notifier.dart';
import 'package:darkoff/presentation/features/maps/state/map_detail_state.dart';
import 'package:darkoff/presentation/features/maps/state/maps_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_detail_notifier.g.dart';

@riverpod
class MapDetailNotifier extends _$MapDetailNotifier {
  @override
  MapDetailState build(String mapId) {
    final state = ref.watch(mapsProvider);

    return switch (state) {
      MapsLoaded(:final maps) => _select(maps, mapId),
      MapsError(:final message) => MapDetailState.error(message),
      _ => const MapDetailState.loading(),
    };
  }

  MapDetailState _select(List<MapUiModel> maps, String mapId) {
    final match = maps.where((m) => m.id == mapId).firstOrNull;
    if (match == null) {
      return const MapDetailState.error('Map not found');
    }
    return MapDetailState.loaded(match);
  }

  Future<void> refresh() => ref.read(mapsProvider.notifier).refresh();
}
