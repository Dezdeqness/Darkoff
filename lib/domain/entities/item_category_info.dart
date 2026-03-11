import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_category_info.freezed.dart';

@freezed
abstract class ItemCategoryInfo with _$ItemCategoryInfo {
  const factory ItemCategoryInfo({
    required String id,
    required String name,
    required String normalizedName,
  }) = _ItemCategoryInfo;
}
