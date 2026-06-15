import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_detail_ui_model.freezed.dart';

enum TaskMetaKind { level, map, experience }

@freezed
abstract class TaskMetaUiModel with _$TaskMetaUiModel {
  const factory TaskMetaUiModel({
    required String label,
    required TaskMetaKind kind,
  }) = _TaskMetaUiModel;
}

@freezed
abstract class TaskObjectiveUiModel with _$TaskObjectiveUiModel {
  const factory TaskObjectiveUiModel({
    required String description,
    @Default(false) bool optional,
  }) = _TaskObjectiveUiModel;
}

@freezed
abstract class TaskRewardItemUiModel with _$TaskRewardItemUiModel {
  const factory TaskRewardItemUiModel({
    required String shortName,
    String? iconLink,
    String? priceLabel,
    required String countLabel,
  }) = _TaskRewardItemUiModel;
}

@freezed
abstract class TaskRewardStandingUiModel with _$TaskRewardStandingUiModel {
  const factory TaskRewardStandingUiModel({
    required String label,
    @Default(true) bool positive,
  }) = _TaskRewardStandingUiModel;
}

@freezed
abstract class TaskDetailUiModel with _$TaskDetailUiModel {
  const factory TaskDetailUiModel({
    required String id,
    required String name,
    required String traderName,
    String? traderImageLink,
    String? taskImageLink,
    @Default(false) bool kappaRequired,
    @Default([]) List<TaskMetaUiModel> meta,
    String? experienceLabel,
    @Default([]) List<String> prerequisiteTaskNames,
    @Default([]) List<TaskObjectiveUiModel> objectives,
    @Default([]) List<TaskRewardItemUiModel> rewardItems,
    @Default([]) List<TaskRewardStandingUiModel> rewardStanding,
  }) = _TaskDetailUiModel;
}
