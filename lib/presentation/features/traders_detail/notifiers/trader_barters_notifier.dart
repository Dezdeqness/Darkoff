import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:darkoff/presentation/features/traders_detail/notifiers/trader_detail_notifier.dart';
import 'package:darkoff/presentation/features/traders_detail/state/trader_barters_state.dart';
import 'package:darkoff/presentation/features/traders_detail/state/trader_detail_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trader_barters_notifier.g.dart';

@riverpod
class TraderBartersNotifier extends _$TraderBartersNotifier {
  int? _selectedLevel;
  List<TraderBarterUiModel> _source = const [];

  @override
  TraderBartersState build(String traderId) {
    final detail = ref.watch(traderDetailProvider(traderId));

    return switch (detail) {
      TraderDetailLoaded(:final model) => _onSource(model.barters),
      TraderDetailError(:final message) => TraderBartersState.error(message),
      _ => const TraderBartersState.loading(),
    };
  }

  TraderBartersState _onSource(List<TraderBarterUiModel> barters) {
    _source = barters;
    return _filtered();
  }

  TraderBartersState _filtered() {
    final levels = <int>{for (final b in _source) b.level}.toList()..sort();

    final selected = (_selectedLevel != null && levels.contains(_selectedLevel))
        ? _selectedLevel
        : null;
    _selectedLevel = selected;

    final barters = selected == null
        ? _source
        : _source.where((b) => b.level == selected).toList();

    return TraderBartersState.loaded(
      barters: barters,
      levels: levels,
      selectedLevel: selected,
    );
  }

  void selectLevel(int? level) {
    _selectedLevel = level;
    if (state is TraderBartersLoaded) {
      state = _filtered();
    }
  }
}
