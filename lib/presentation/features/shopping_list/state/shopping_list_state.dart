import 'package:darkoff/presentation/features/shopping_list/model/shopping_list_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list_state.freezed.dart';

@freezed
class ShoppingListState with _$ShoppingListState {
  const factory ShoppingListState.loading() = ShoppingListLoading;
  const factory ShoppingListState.empty() = ShoppingListEmpty;
  const factory ShoppingListState.loaded(ShoppingListUiModel model) =
      ShoppingListLoaded;
}
