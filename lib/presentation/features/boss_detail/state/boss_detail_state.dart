import 'package:darkoff/presentation/features/boss_detail/model/boss_detail_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'boss_detail_state.freezed.dart';

@freezed
class BossDetailState with _$BossDetailState {
  const factory BossDetailState.initial() = BossDetailInitial;
  const factory BossDetailState.loading() = BossDetailLoading;
  const factory BossDetailState.loaded(BossDetailUiModel boss) =
      BossDetailLoaded;
  const factory BossDetailState.error(String message) = BossDetailError;
}
