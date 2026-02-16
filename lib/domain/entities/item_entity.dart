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
  }) = _ItemEntity;
}
