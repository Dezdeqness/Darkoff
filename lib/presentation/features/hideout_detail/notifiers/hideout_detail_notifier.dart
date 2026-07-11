import 'package:darkoff/presentation/features/hideout/notifiers/hideout_notifier.dart';
import 'package:darkoff/presentation/features/hideout/notifiers/hideout_progress_notifier.dart';
import 'package:darkoff/presentation/features/hideout/state/hideout_state.dart';
import 'package:darkoff/presentation/features/hideout_detail/mapper/hideout_detail_ui_mapper.dart';
import 'package:darkoff/presentation/features/hideout_detail/state/hideout_detail_state.dart';
import 'package:darkoff/service_locator/hideout_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hideout_detail_notifier.g.dart';

@riverpod
class HideoutDetailNotifier extends _$HideoutDetailNotifier {
  late HideoutDetailUiMapper _mapper;

  @override
  HideoutDetailState build(String stationId) {
    _mapper = getIt<HideoutDetailUiMapper>();

    final hideoutState = ref.watch(hideoutProvider);
    final progress = ref.watch(hideoutProgressProvider);

    return hideoutState.when(
      initial: () => const HideoutDetailState.loading(),
      loading: () => const HideoutDetailState.loading(),
      empty: () => const HideoutDetailState.error('Station not found'),
      loaded: (stations) {
        for (final station in stations) {
          if (station.id == stationId) {
            return HideoutDetailState.loaded(
              _mapper.fromEntity(station, progress),
            );
          }
        }
        return const HideoutDetailState.error('Station not found');
      },
      error: HideoutDetailState.error,
    );
  }

  Future<void> retry() => ref.read(hideoutProvider.notifier).refresh();
}
