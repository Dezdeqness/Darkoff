import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:darkoff/presentation/features/traders_detail/notifiers/trader_detail_notifier.dart';
import 'package:darkoff/presentation/features/traders_detail/state/trader_detail_state.dart';
import 'package:darkoff/presentation/features/traders_detail/state/trader_offers_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trader_offers_notifier.g.dart';

@riverpod
class TraderOffersNotifier extends _$TraderOffersNotifier {
  int? _selectedLevel;
  List<TraderOfferUiModel> _source = const [];

  @override
  TraderOffersState build(String traderId) {
    final detail = ref.watch(traderDetailProvider(traderId));

    return switch (detail) {
      TraderDetailLoaded(:final model) => _onSource(model.offers),
      TraderDetailError(:final message) => TraderOffersState.error(message),
      _ => const TraderOffersState.loading(),
    };
  }

  TraderOffersState _onSource(List<TraderOfferUiModel> offers) {
    _source = offers;
    return _filtered();
  }

  TraderOffersState _filtered() {
    final levels = <int>{
      for (final o in _source)
        if (o.minTraderLevel != null) o.minTraderLevel!,
    }.toList()
      ..sort();

    final selected = (_selectedLevel != null && levels.contains(_selectedLevel))
        ? _selectedLevel
        : null;
    _selectedLevel = selected;

    final offers = selected == null
        ? _source
        : _source.where((o) => o.minTraderLevel == selected).toList();

    return TraderOffersState.loaded(
      offers: offers,
      levels: levels,
      selectedLevel: selected,
    );
  }

  void selectLevel(int? level) {
    _selectedLevel = level;
    if (state is TraderOffersLoaded) {
      state = _filtered();
    }
  }
}
