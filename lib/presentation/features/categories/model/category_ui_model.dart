import 'package:darkoff/domain/entities/item_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_ui_model.freezed.dart';

@freezed
abstract class CategoryUiModel with _$CategoryUiModel {
  const factory CategoryUiModel({
    required String key,
    required String displayText,
    required String imageUrl,
    required List<ItemType> types,
  }) = _CategoryUiModel;
}
