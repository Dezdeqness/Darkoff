import 'package:darkoff/domain/entities/craft_entity.dart';
import 'package:darkoff/presentation/features/crafts/mapper/crafts_list_ui_mapper.dart';
import 'package:darkoff/presentation/features/crafts/model/crafts_list_ui_model.dart';
import 'package:darkoff/presentation/features/crafts/notifiers/crafts_notifier.dart';
import 'package:darkoff/presentation/features/crafts/state/crafts_list_state.dart';
import 'package:darkoff/presentation/features/crafts/state/crafts_state.dart';
import 'package:darkoff/service_locator/crafts_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'crafts_list_notifier.g.dart';

@riverpod
class CraftsListNotifier extends _$CraftsListNotifier {
  late CraftsListUiMapper _mapper;

  String _selectedStation = '';
  CraftSort _sort = CraftSort.profitPerHour;

  @override
  CraftsListState build() {
    _mapper = getIt<CraftsListUiMapper>();

    final state = ref.watch(craftsProvider);

    return switch (state) {
      CraftsLoaded(:final crafts) => CraftsListState.loaded(_map(crafts)),
      CraftsError(:final message) => CraftsListState.error(message),
      _ => const CraftsListState.loading(),
    };
  }

  void selectStation(String station) {
    _selectedStation = station;
    _recompute();
  }

  void toggleSort() {
    _sort = _sort == CraftSort.profitPerHour
        ? CraftSort.totalProfit
        : CraftSort.profitPerHour;
    _recompute();
  }

  Future<void> refresh() => ref.read(craftsProvider.notifier).refresh();

  void _recompute() {
    final raw = ref.read(craftsProvider);
    if (raw is CraftsLoaded) {
      state = CraftsListState.loaded(_map(raw.crafts));
    }
  }

  CraftsListUiModel _map(List<CraftEntity> crafts) =>
      _mapper.build(crafts, selectedStation: _selectedStation, sort: _sort);
}
