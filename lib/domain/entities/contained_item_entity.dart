import 'package:freezed_annotation/freezed_annotation.dart';

part 'contained_item_entity.freezed.dart';

@freezed
abstract class ContainedItemEntity with _$ContainedItemEntity {
  const factory ContainedItemEntity({
    required String id,
    required String name,
    required String shortName,
    String? iconLink,
    int? price,
    required double count,
  }) = _ContainedItemEntity;
}
