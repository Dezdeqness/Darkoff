import 'package:darkoff/presentation/features/crafts/model/crafts_list_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'crafts_list_state.freezed.dart';

@freezed
class CraftsListState with _$CraftsListState {
  const factory CraftsListState.loading() = CraftsListLoading;
  const factory CraftsListState.loaded(CraftsListUiModel crafts) =
      CraftsListLoaded;
  const factory CraftsListState.error(String message) = CraftsListError;
}
