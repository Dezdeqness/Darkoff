import 'package:darkoff/domain/repositories/flea_repository.dart';
import 'package:darkoff/presentation/features/home/mapper/price_change_ui_mapper.dart';
import 'package:darkoff/presentation/features/home/state/price_changes_state.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'price_changes_notifier.g.dart';

@riverpod
class PriceChangesNotifier extends _$PriceChangesNotifier {
  late FleaRepository _repository;
  late PriceChangeUiMapper _mapper;

  @override
  PriceChangesState build() {
    _repository = getIt<FleaRepository>();
    _mapper = getIt<PriceChangeUiMapper>();
    load();
    return const PriceChangesState.initial();
  }

  Future<void> load() async {
    state = const PriceChangesState.loading();
    final result = await _repository.getFleaItems();
    result.fold(
      (items) {
        final movers = _mapper.fromEntityList(items);
        state = movers.isEmpty
            ? const PriceChangesState.empty()
            : PriceChangesState.loaded(movers);
      },
      (error) => state = PriceChangesState.error(error.toString()),
    );
  }

  Future<void> refresh() => load();
}
