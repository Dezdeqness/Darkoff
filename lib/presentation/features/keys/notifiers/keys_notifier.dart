import 'package:keys_contract/keys_contract.dart';
import 'package:darkoff/presentation/features/keys/state/keys_state.dart';
import 'package:darkoff/service_locator/keys_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'keys_notifier.g.dart';

@riverpod
class KeysNotifier extends _$KeysNotifier {
  late KeysRepository _repository;

  @override
  KeysState build() {
    _repository = getIt<KeysRepository>();
    _load();
    return const KeysState.initial();
  }

  Future<void> _load() async {
    state = const KeysState.loading();
    try {
      final result = await _repository.getKeys();
      result.fold(
        (keys) => state = KeysState.loaded(keys),
        (error) => state = KeysState.error(error.toString()),
      );
    } catch (e) {
      state = KeysState.error(e.toString());
    }
  }

  Future<void> refresh() async => _load();
}
