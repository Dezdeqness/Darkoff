import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_entity.freezed.dart';

@freezed
abstract class TaskEntity with _$TaskEntity {
  const factory TaskEntity({
    required String id,
    required String name,
    required String traderName,
    required String traderNormalizedName,
    String? traderId,
    String? traderImageLink,
    String? mapId,
    String? mapName,
    @Default(false) bool kappaRequired,
    required int experience,
    int? minPlayerLevel,
    String? taskImageLink,
    String? wikiLink,
    @Default([]) List<TaskObjectiveEntity> objectives,
    @Default([]) List<TaskPrerequisiteEntity> prerequisites,
    @Default([]) List<TaskRewardItemEntity> rewardItems,
    @Default([]) List<TaskRewardStandingEntity> rewardStanding,
  }) = _TaskEntity;
}

@freezed
abstract class TaskObjectiveEntity with _$TaskObjectiveEntity {
  const factory TaskObjectiveEntity({
    required String description,
    required String type,
    @Default(false) bool optional,
  }) = _TaskObjectiveEntity;
}

@freezed
abstract class TaskPrerequisiteEntity with _$TaskPrerequisiteEntity {
  const factory TaskPrerequisiteEntity({
    required String taskId,
    required String taskName,
  }) = _TaskPrerequisiteEntity;
}

@freezed
abstract class TaskRewardItemEntity with _$TaskRewardItemEntity {
  const factory TaskRewardItemEntity({
    required String id,
    required String name,
    required String shortName,
    String? iconLink,
    int? price,
    required int count,
  }) = _TaskRewardItemEntity;
}

@freezed
abstract class TaskRewardStandingEntity with _$TaskRewardStandingEntity {
  const factory TaskRewardStandingEntity({
    required String traderName,
    String? traderId,
    required double standing,
  }) = _TaskRewardStandingEntity;
}
