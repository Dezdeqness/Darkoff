import 'package:darkoff/domain/repositories/traders_repository.dart';
import 'package:darkoff/presentation/features/traders/state/traders_state.dart';
import 'package:darkoff/service_locator/traders_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'traders_notifier.g.dart';

@riverpod
class TradersNotifier extends _$TradersNotifier {
  late TradersRepository _repository;

  @override
  TradersState build() {
    _repository = getIt<TradersRepository>();
    _load();
    return const TradersState.initial();
  }

  Future<void> _load() async {
    state = const TradersState.loading();
    try {
      final result = await _repository.getTraders();
      result.fold(
        (traders) => state = TradersState.loaded(traders),
        (error) => state = TradersState.error(error.toString()),
      );
    } catch (e) {
      state = TradersState.error(e.toString());
    }
  }

  Future<void> refresh() async => _load();
}
