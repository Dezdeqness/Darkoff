import 'package:freezed_annotation/freezed_annotation.dart';

part 'shopping_list_ui_model.freezed.dart';

@freezed
abstract class ShoppingListRowUiModel with _$ShoppingListRowUiModel {
  const factory ShoppingListRowUiModel({
    required String itemId,
    required String shortName,
    String? iconLink,
    required String sourcesText,
    required String countText,
    String? displayCost,
  }) = _ShoppingListRowUiModel;
}

@freezed
abstract class ShoppingListUiModel with _$ShoppingListUiModel {
  const factory ShoppingListUiModel({
    required String title,
    String? displayCost,
    @Default([]) List<ShoppingListRowUiModel> rows,
  }) = _ShoppingListUiModel;
}
