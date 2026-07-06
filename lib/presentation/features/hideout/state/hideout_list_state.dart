import 'package:darkoff/presentation/features/hideout/model/hideout_list_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hideout_list_state.freezed.dart';

@freezed
class HideoutListState with _$HideoutListState {
  const factory HideoutListState.loading() = HideoutListLoading;
  const factory HideoutListState.empty() = HideoutListEmpty;
  const factory HideoutListState.loaded(HideoutListUiModel model) =
      HideoutListLoaded;
  const factory HideoutListState.error(String message) = HideoutListError;
}
