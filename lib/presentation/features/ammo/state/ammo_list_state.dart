import 'package:darkoff/presentation/features/ammo/model/ammo_list_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ammo_list_state.freezed.dart';

@freezed
class AmmoListState with _$AmmoListState {
  const factory AmmoListState.loading() = AmmoListLoading;
  const factory AmmoListState.loaded(AmmoListUiModel ammo) = AmmoListLoaded;
  const factory AmmoListState.error(String message) = AmmoListError;
}
