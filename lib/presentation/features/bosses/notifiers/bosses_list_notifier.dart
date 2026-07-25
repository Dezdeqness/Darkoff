import 'package:darkoff/presentation/features/bosses/mapper/boss_list_ui_mapper.dart';
import 'package:darkoff/presentation/features/bosses/notifiers/bosses_notifier.dart';
import 'package:darkoff/presentation/features/bosses/state/bosses_list_state.dart';
import 'package:darkoff/presentation/features/bosses/state/bosses_state.dart';
import 'package:darkoff/service_locator/boss_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bosses_list_notifier.g.dart';

@riverpod
class BossesListNotifier extends _$BossesListNotifier {
  late BossListUiMapper _mapper;

  @override
  BossesListState build() {
    _mapper = getIt<BossListUiMapper>();

    final state = ref.watch(bossesProvider);

    return switch (state) {
      BossesLoaded(:final bosses) =>
        BossesListState.loaded(_mapper.toListModel(bosses)),
      BossesError(:final message) => BossesListState.error(message),
      _ => const BossesListState.loading(),
    };
  }

  Future<void> refresh() => ref.read(bossesProvider.notifier).refresh();
}
