import 'package:maps_contract/maps_contract.dart';
import 'package:darkoff/presentation/features/maps/mapper/map_ui_mapper.dart';
import 'package:darkoff/presentation/features/maps/state/maps_state.dart';
import 'package:darkoff/service_locator/maps_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'maps_notifier.g.dart';

@riverpod
class MapsNotifier extends _$MapsNotifier {
  late MapsRepository _repository;
  late MapUiMapper _mapper;

  @override
  MapsState build() {
    _repository = getIt<MapsRepository>();
    _mapper = getIt<MapUiMapper>();
    loadMaps();
    return const MapsState.initial();
  }

  Future<void> loadMaps() async {
    state = const MapsState.loading();

    try {
      final result = await _repository.getMaps();

      result.fold(
        (maps) {
          if (maps.isEmpty) {
            state = const MapsState.empty();
          } else {
            state = MapsState.loaded(_mapper.fromEntities(maps));
          }
        },
        (error) {
          state = MapsState.error(error.toString());
        },
      );
    } catch (e) {
      state = MapsState.error(e.toString());
    }
  }

  Future<void> refresh() async {
    await loadMaps();
  }
}
