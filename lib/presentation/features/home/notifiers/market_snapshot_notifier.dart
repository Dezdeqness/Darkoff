import 'dart:async';

import 'package:darkoff/data/cache/cache_value.dart';
import 'package:darkoff/data/cache/market_cache_manager.dart';
import 'package:market_contract/market_contract.dart';
import 'package:darkoff/presentation/features/home/mapper/market_item_ui_mapper.dart';
import 'package:darkoff/presentation/features/home/state/market_snapshot_state.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'market_snapshot_notifier.g.dart';

@riverpod
class MarketSnapshotNotifier extends _$MarketSnapshotNotifier {
  late final MarketCacheManager _manager;
  late final MarketItemUiMapper _mapper;
  StreamSubscription<CacheValue<List<MarketItemEntity>>>? _subscription;

  @override
  MarketSnapshotState build() {
    _manager = getIt<MarketCacheManager>();
    _mapper = getIt<MarketItemUiMapper>();
    ref.onDispose(() => _subscription?.cancel());
    _subscription = _manager.observe(_onChange);
    return const MarketSnapshotState.initial();
  }

  void _onChange(CacheValue<List<MarketItemEntity>> value) {
    state = value.when(
      loading: () => const MarketSnapshotState.loading(),
      data: (items) => items.isEmpty
          ? const MarketSnapshotState.empty()
          : MarketSnapshotState.loaded(_mapper.fromEntities(items)),
      error: (error, _) => MarketSnapshotState.error(error.toString()),
    );
  }

  Future<void> refresh() => _manager.updateData();
}
