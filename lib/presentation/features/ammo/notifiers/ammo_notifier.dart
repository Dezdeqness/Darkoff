import 'package:darkoff/domain/repositories/ammo_repository.dart';
import 'package:darkoff/presentation/features/ammo/state/ammo_state.dart';
import 'package:darkoff/service_locator/ammo_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ammo_notifier.g.dart';

@riverpod
class AmmoNotifier extends _$AmmoNotifier {
  late AmmoRepository _repository;

  @override
  AmmoState build() {
    _repository = getIt<AmmoRepository>();
    _load();
    return const AmmoState.initial();
  }

  Future<void> _load() async {
    state = const AmmoState.loading();
    try {
      final result = await _repository.getAmmo();
      result.fold(
        (ammo) => state = AmmoState.loaded(ammo),
        (error) => state = AmmoState.error(error.toString()),
      );
    } catch (e) {
      state = AmmoState.error(e.toString());
    }
  }

  Future<void> refresh() async => _load();
}
