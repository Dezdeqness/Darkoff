import 'package:darkoff/presentation/features/flea_market/model/flea_item_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'flea_category_state.freezed.dart';

@freezed
class FleaCategoryState with _$FleaCategoryState {
  const factory FleaCategoryState.loading() = FleaCategoryLoading;
  const factory FleaCategoryState.loaded(List<FleaItemUiModel> items) = FleaCategoryLoaded;
  const factory FleaCategoryState.error(String message) = FleaCategoryError;
}
