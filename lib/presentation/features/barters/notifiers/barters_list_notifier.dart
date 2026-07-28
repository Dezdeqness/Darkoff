import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:darkoff/presentation/features/barters/mapper/barters_list_ui_mapper.dart';
import 'package:darkoff/presentation/features/barters/model/barters_list_ui_model.dart';
import 'package:darkoff/presentation/features/barters/notifiers/barters_notifier.dart';
import 'package:darkoff/presentation/features/barters/state/barters_list_state.dart';
import 'package:darkoff/presentation/features/barters/state/barters_state.dart';
import 'package:darkoff/service_locator/barters_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'barters_list_notifier.g.dart';

@riverpod
class BartersListNotifier extends _$BartersListNotifier {
  late BartersListUiMapper _mapper;

  String _selectedTrader = '';
  BarterSort _sort = BarterSort.profitDesc;

  @override
  BartersListState build() {
    _mapper = getIt<BartersListUiMapper>();

    final state = ref.watch(bartersProvider);

    return switch (state) {
      BartersLoaded(:final barters) => BartersListState.loaded(_map(barters)),
      BartersError(:final message) => BartersListState.error(message),
      _ => const BartersListState.loading(),
    };
  }

  void selectTrader(String trader) {
    _selectedTrader = trader;
    _recompute();
  }

  void toggleSort() {
    _sort = _sort == BarterSort.profitDesc
        ? BarterSort.profitAsc
        : BarterSort.profitDesc;
    _recompute();
  }

  Future<void> refresh() => ref.read(bartersProvider.notifier).refresh();

  void _recompute() {
    final raw = ref.read(bartersProvider);
    if (raw is BartersLoaded) {
      state = BartersListState.loaded(_map(raw.barters));
    }
  }

  BartersListUiModel _map(List<BarterEntity> barters) =>
      _mapper.build(barters, selectedTrader: _selectedTrader, sort: _sort);
}
