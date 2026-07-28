import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'craft_entity.freezed.dart';

@freezed
abstract class CraftEntity with _$CraftEntity {
  const factory CraftEntity({
    required String id,
    required String stationName,
    required String stationNormalizedName,
    required int level,
    required int duration,
    @Default([]) List<ContainedItemEntity> requiredItems,
    @Default([]) List<ContainedItemEntity> rewardItems,
  }) = _CraftEntity;
}
