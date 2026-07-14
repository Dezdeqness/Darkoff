import 'package:darkoff/domain/entities/trader_entity.dart';
import 'package:darkoff/presentation/features/traders/notifiers/traders_notifier.dart';
import 'package:darkoff/presentation/features/traders/state/traders_state.dart';
import 'package:darkoff/presentation/features/traders_detail/mapper/trader_detail_ui_mapper.dart';
import 'package:darkoff/presentation/features/traders_detail/state/trader_detail_state.dart';
import 'package:darkoff/service_locator/traders_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trader_detail_notifier.g.dart';

@riverpod
class TraderDetailNotifier extends _$TraderDetailNotifier {
  late TraderDetailUiMapper _mapper;

  @override
  TraderDetailState build(String traderId) {
    _mapper = getIt<TraderDetailUiMapper>();

    final state = ref.watch(tradersProvider);

    return switch (state) {
      TradersLoaded(:final traders) => _onLoaded(traders, traderId),
      TradersError(:final message) => TraderDetailState.error(message),
      _ => const TraderDetailState.loading(),
    };
  }

  TraderDetailState _onLoaded(List<TraderEntity> traders, String id) {
    for (final trader in traders) {
      if (trader.id == id) {
        return TraderDetailState.loaded(_mapper.toModel(trader));
      }
    }
    return const TraderDetailState.error('Trader not found');
  }

  Future<void> refresh() => ref.read(tradersProvider.notifier).refresh();
}
