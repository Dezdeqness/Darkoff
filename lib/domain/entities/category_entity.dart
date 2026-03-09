import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_entity.freezed.dart';

@freezed
abstract class CategoryEntity with _$CategoryEntity {
  const factory CategoryEntity({
    required String key,
    required String displayText,
    required String icon,
    required List<String> categoryNames,
  }) = _CategoryEntity;
}
