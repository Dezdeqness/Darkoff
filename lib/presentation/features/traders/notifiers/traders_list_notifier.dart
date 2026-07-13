import 'package:darkoff/presentation/features/traders/mapper/trader_list_ui_mapper.dart';
import 'package:darkoff/presentation/features/traders/notifiers/traders_notifier.dart';
import 'package:darkoff/presentation/features/traders/state/traders_list_state.dart';
import 'package:darkoff/presentation/features/traders/state/traders_state.dart';
import 'package:darkoff/service_locator/traders_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'traders_list_notifier.g.dart';

@riverpod
class TradersListNotifier extends _$TradersListNotifier {
  late TraderListUiMapper _mapper;

  @override
  TradersListState build() {
    _mapper = getIt<TraderListUiMapper>();

    final state = ref.watch(tradersProvider);

    return switch (state) {
      TradersLoaded(:final traders) =>
        TradersListState.loaded(_mapper.toListModel(traders)),
      TradersError(:final message) => TradersListState.error(message),
      _ => const TradersListState.loading(),
    };
  }

  Future<void> refresh() => ref.read(tradersProvider.notifier).refresh();
}
