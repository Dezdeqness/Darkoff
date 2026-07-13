import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'barter_entity.freezed.dart';

@freezed
abstract class BarterEntity with _$BarterEntity {
  const factory BarterEntity({
    required String id,
    required String traderName,
    required String traderNormalizedName,
    required int level,
    @Default([]) List<ContainedItemEntity> requiredItems,
    @Default([]) List<ContainedItemEntity> rewardItems,
  }) = _BarterEntity;
}
