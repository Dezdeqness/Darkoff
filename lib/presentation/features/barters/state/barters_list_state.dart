import 'package:darkoff/presentation/features/barters/model/barters_list_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'barters_list_state.freezed.dart';

@freezed
class BartersListState with _$BartersListState {
  const factory BartersListState.loading() = BartersListLoading;
  const factory BartersListState.loaded(BartersListUiModel barters) =
      BartersListLoaded;
  const factory BartersListState.error(String message) = BartersListError;
}
