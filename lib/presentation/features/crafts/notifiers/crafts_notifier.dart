import 'package:darkoff/domain/repositories/crafts_repository.dart';
import 'package:darkoff/presentation/features/crafts/state/crafts_state.dart';
import 'package:darkoff/service_locator/crafts_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'crafts_notifier.g.dart';

@riverpod
class CraftsNotifier extends _$CraftsNotifier {
  late CraftsRepository _repository;

  @override
  CraftsState build() {
    _repository = getIt<CraftsRepository>();
    _load();
    return const CraftsState.initial();
  }

  Future<void> _load() async {
    state = const CraftsState.loading();
    try {
      final result = await _repository.getCrafts();
      result.fold(
        (crafts) => state = CraftsState.loaded(crafts),
        (error) => state = CraftsState.error(error.toString()),
      );
    } catch (e) {
      state = CraftsState.error(e.toString());
    }
  }

  Future<void> refresh() async => _load();
}
