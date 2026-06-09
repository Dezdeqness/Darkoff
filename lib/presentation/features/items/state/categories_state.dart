import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/category_ui_model.dart';

part 'categories_state.freezed.dart';

@freezed
abstract class CategoriesState with _$CategoriesState {
  const factory CategoriesState({
    required List<CategoryUiModel> categories,
    @Default(0) int selectedIndex,
  }) = _CategoriesState;
}
