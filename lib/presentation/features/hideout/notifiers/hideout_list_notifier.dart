import 'package:darkoff/domain/entities/hideout_progress_entity.dart';
import 'package:darkoff/presentation/features/hideout/mapper/hideout_ui_mapper.dart';
import 'package:darkoff/presentation/features/hideout/notifiers/hideout_notifier.dart';
// import 'package:darkoff/presentation/features/hideout/notifiers/hideout_progress_notifier.dart';
import 'package:darkoff/presentation/features/hideout/state/hideout_list_state.dart';
import 'package:darkoff/presentation/features/hideout/state/hideout_state.dart';
import 'package:darkoff/service_locator/hideout_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hideout_list_notifier.g.dart';

@riverpod
class HideoutListNotifier extends _$HideoutListNotifier {
  late HideoutUiMapper _mapper;

  @override
  HideoutListState build() {
    _mapper = getIt<HideoutUiMapper>();

    final state = ref.watch(hideoutProvider);
    // final progress = ref.watch(hideoutProgressProvider);

    return state.when(
      initial: () => const HideoutListState.loading(),
      loading: () => const HideoutListState.loading(),
      empty: () => const HideoutListState.empty(),
      loaded: (stations) =>
          HideoutListState.loaded(_mapper.toListModel(stations, HideoutProgressEntity())),
      error: HideoutListState.error,
    );
  }

  Future<void> refresh() => ref.read(hideoutProvider.notifier).refresh();
}
