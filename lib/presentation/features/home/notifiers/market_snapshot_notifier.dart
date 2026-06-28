import 'package:darkoff/domain/repositories/market_repository.dart';
import 'package:darkoff/presentation/features/home/mapper/market_item_ui_mapper.dart';
import 'package:darkoff/presentation/features/home/state/market_snapshot_state.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'market_snapshot_notifier.g.dart';

@riverpod
class MarketSnapshotNotifier extends _$MarketSnapshotNotifier {
  late MarketRepository _repository;
  late MarketItemUiMapper _mapper;

  @override
  MarketSnapshotState build() {
    _repository = getIt<MarketRepository>();
    _mapper = getIt<MarketItemUiMapper>();
    load();
    return const MarketSnapshotState.initial();
  }

  Future<void> load() async {
    state = const MarketSnapshotState.loading();
    final result = await _repository.getMarketOverview();
    result.fold(
      (items) {
        state = items.isEmpty
            ? const MarketSnapshotState.empty()
            : MarketSnapshotState.loaded(_mapper.fromEntities(items));
      },
      (error) => state = MarketSnapshotState.error(error.toString()),
    );
  }

  Future<void> refresh() => load();
}
