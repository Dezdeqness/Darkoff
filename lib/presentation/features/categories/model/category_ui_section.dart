import 'package:darkoff/presentation/features/categories/model/category_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_ui_section.freezed.dart';

@freezed
abstract class CategoryUiSection with _$CategoryUiSection {
  const factory CategoryUiSection({
    required String key,
    required String header,
    required List<CategoryUiModel> items,
  }) = _CategoryUiSection;
}
