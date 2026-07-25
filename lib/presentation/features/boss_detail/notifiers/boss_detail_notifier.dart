import 'package:darkoff/domain/entities/boss_entity.dart';
import 'package:darkoff/presentation/features/boss_detail/mapper/boss_detail_ui_mapper.dart';
import 'package:darkoff/presentation/features/boss_detail/state/boss_detail_state.dart';
import 'package:darkoff/presentation/features/bosses/notifiers/bosses_notifier.dart';
import 'package:darkoff/presentation/features/bosses/state/bosses_state.dart';
import 'package:darkoff/service_locator/boss_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'boss_detail_notifier.g.dart';

@riverpod
class BossDetailNotifier extends _$BossDetailNotifier {
  late final BossDetailUiMapper _mapper = getIt<BossDetailUiMapper>();

  @override
  BossDetailState build(String bossId) {
    final bossesState = ref.watch(bossesProvider);

    return switch (bossesState) {
      BossesInitial() || BossesLoading() => const BossDetailState.loading(),
      BossesError(:final message) => BossDetailState.error(message),
      BossesLoaded(:final bosses) => _select(bosses, bossId),
      _ => const BossDetailState.loading(),
    };
  }

  BossDetailState _select(List<BossEntity> bosses, String bossId) {
    final match = bosses.where((b) => b.id == bossId).firstOrNull;
    if (match == null) {
      return const BossDetailState.error('Boss not found');
    }
    return BossDetailState.loaded(_mapper.fromEntity(match));
  }

  Future<void> refresh() async =>
      ref.read(bossesProvider.notifier).refresh();
}
