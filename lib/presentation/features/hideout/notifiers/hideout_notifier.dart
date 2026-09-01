import 'package:hideout_contract/hideout_contract.dart';
import 'package:darkoff/presentation/features/hideout/state/hideout_state.dart';
import 'package:darkoff/service_locator/hideout_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hideout_notifier.g.dart';

@riverpod
class HideoutNotifier extends _$HideoutNotifier {
  late HideoutRepository _repository;

  @override
  HideoutState build() {
    _repository = getIt<HideoutRepository>();
    _load();
    return const HideoutState.initial();
  }

  Future<void> _load() async {
    state = const HideoutState.loading();
    try {
      final result = await _repository.getStations();
      result.fold(
        (stations) {
          if (stations.isEmpty) {
            state = const HideoutState.empty();
          } else {
            state = HideoutState.loaded(stations);
          }
        },
        (error) => state = HideoutState.error(error.toString()),
      );
    } catch (e) {
      state = HideoutState.error(e.toString());
    }
  }

  Future<void> refresh() async => _load();
}
