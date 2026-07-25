import 'package:darkoff/domain/repositories/boss_repository.dart';
import 'package:darkoff/presentation/features/bosses/state/bosses_state.dart';
import 'package:darkoff/service_locator/boss_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bosses_notifier.g.dart';

@riverpod
class BossesNotifier extends _$BossesNotifier {
  late BossRepository _repository;

  @override
  BossesState build() {
    _repository = getIt<BossRepository>();
    _load();
    return const BossesState.initial();
  }

  Future<void> _load() async {
    state = const BossesState.loading();
    try {
      final result = await _repository.getBosses();
      result.fold(
        (bosses) => state = BossesState.loaded(bosses),
        (error) => state = BossesState.error(error.toString()),
      );
    } catch (e) {
      state = BossesState.error(e.toString());
    }
  }

  Future<void> refresh() async => _load();
}
