import 'package:darkoff/presentation/features/hideout_detail/model/hideout_detail_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'hideout_detail_state.freezed.dart';

@freezed
class HideoutDetailState with _$HideoutDetailState {
  const factory HideoutDetailState.initial() = HideoutDetailInitial;
  const factory HideoutDetailState.loading() = HideoutDetailLoading;
  const factory HideoutDetailState.loaded(HideoutDetailUiModel detail) =
      HideoutDetailLoaded;
  const factory HideoutDetailState.error(String message) = HideoutDetailError;
}
