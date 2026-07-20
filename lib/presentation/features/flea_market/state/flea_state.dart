import 'package:darkoff/presentation/features/flea_market/model/flea_item_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flea_state.freezed.dart';

@freezed
class FleaState with _$FleaState {
  const factory FleaState.initial() = FleaInitial;
  const factory FleaState.loading() = FleaLoading;
  const factory FleaState.loaded(List<FleaItemUiModel> items) = FleaLoaded;
  const factory FleaState.error(String message) = FleaError;
}
