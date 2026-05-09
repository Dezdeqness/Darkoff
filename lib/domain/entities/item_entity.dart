import 'package:darkoff/domain/entities/item_category_info.dart';
import 'package:darkoff/domain/entities/item_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_entity.freezed.dart';

@freezed
abstract class ItemEntity with _$ItemEntity {
  const factory ItemEntity({
    required String id,
    required String? name,
    required String? shortName,
    required int basePrice,
    required String backgroundColor,
    required String? iconLink,
    required String? baseImageLink,
    required String? image512pxLink,
    int? width,
    int? height,
    @Default([]) List<ItemType> types,
    @Default([]) List<ItemCategoryInfo> categories,
  }) = _ItemEntity;
}
