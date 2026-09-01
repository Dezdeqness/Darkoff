import 'dart:async';

import 'package:darkoff/data/cache/cache_value.dart';
import 'package:darkoff/data/cache/flea_cache_manager.dart';
import 'package:flea_contract/flea_contract.dart';
import 'package:darkoff/presentation/features/home/mapper/price_change_ui_mapper.dart';
import 'package:darkoff/presentation/features/home/state/price_changes_state.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'price_changes_notifier.g.dart';

@riverpod
class PriceChangesNotifier extends _$PriceChangesNotifier {
  late final FleaCacheManager _manager;
  late final PriceChangeUiMapper _mapper;
  StreamSubscription<CacheValue<List<FleaItemEntity>>>? _subscription;

  @override
  PriceChangesState build() {
    _manager = getIt<FleaCacheManager>();
    _mapper = getIt<PriceChangeUiMapper>();
    ref.onDispose(() => _subscription?.cancel());
    _subscription = _manager.observe(_onChange);
    return const PriceChangesState.initial();
  }

  void _onChange(CacheValue<List<FleaItemEntity>> value) {
    state = value.when(
      loading: () => const PriceChangesState.loading(),
      data: (items) {
        final movers = _mapper.fromEntityList(items);
        return movers.isEmpty
            ? const PriceChangesState.empty()
            : PriceChangesState.loaded(movers);
      },
      error: (error, _) => PriceChangesState.error(error.toString()),
    );
  }

  Future<void> refresh() => _manager.updateData();
}
