import 'package:darkoff/presentation/features/item_detail/model/item_detail_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_detail_state.freezed.dart';

@freezed
class ItemDetailState with _$ItemDetailState {
  const factory ItemDetailState.initial() = ItemDetailInitial;
  const factory ItemDetailState.loading() = ItemDetailLoading;
  const factory ItemDetailState.loaded(ItemDetailUiModel item) = ItemDetailLoaded;
  const factory ItemDetailState.error(String message) = ItemDetailError;
}
