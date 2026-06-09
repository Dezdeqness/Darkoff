import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_ui_model.freezed.dart';

@freezed
abstract class CategoryUiModel with _$CategoryUiModel {
  const factory CategoryUiModel({
    required String label,
    @Default([]) List<String> names,
  }) = _CategoryUiModel;
}
