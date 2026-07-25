import 'package:darkoff/presentation/features/bosses/model/boss_list_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bosses_list_state.freezed.dart';

@freezed
class BossesListState with _$BossesListState {
  const factory BossesListState.loading() = BossesListLoading;
  const factory BossesListState.loaded(List<BossListItemUiModel> bosses) =
      BossesListLoaded;
  const factory BossesListState.error(String message) = BossesListError;
}
