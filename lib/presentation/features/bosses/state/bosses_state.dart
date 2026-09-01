import 'package:boss_contract/boss_contract.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bosses_state.freezed.dart';

@freezed
class BossesState with _$BossesState {
  const factory BossesState.initial() = BossesInitial;
  const factory BossesState.loading() = BossesLoading;
  const factory BossesState.loaded(List<BossEntity> bosses) = BossesLoaded;
  const factory BossesState.error(String message) = BossesError;
}
