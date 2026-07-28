import 'package:darkoff/domain/repositories/barters_repository.dart';
import 'package:darkoff/presentation/features/barters/state/barters_state.dart';
import 'package:darkoff/service_locator/barters_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'barters_notifier.g.dart';

@riverpod
class BartersNotifier extends _$BartersNotifier {
  late BartersRepository _repository;

  @override
  BartersState build() {
    _repository = getIt<BartersRepository>();
    _load();
    return const BartersState.initial();
  }

  Future<void> _load() async {
    state = const BartersState.loading();
    try {
      final result = await _repository.getBarters();
      result.fold(
        (barters) => state = BartersState.loaded(barters),
        (error) => state = BartersState.error(error.toString()),
      );
    } catch (e) {
      state = BartersState.error(e.toString());
    }
  }

  Future<void> refresh() async => _load();
}
