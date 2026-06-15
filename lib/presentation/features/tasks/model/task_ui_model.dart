import 'package:freezed_annotation/freezed_annotation.dart';

part 'task_ui_model.freezed.dart';

@freezed
abstract class TaskObjectiveUiModel with _$TaskObjectiveUiModel {
  const factory TaskObjectiveUiModel({
    required String description,
    required String type,
    @Default(false) bool optional,
  }) = _TaskObjectiveUiModel;
}

@freezed
abstract class TaskRewardItemUiModel with _$TaskRewardItemUiModel {
  const factory TaskRewardItemUiModel({
    required String name,
    required String shortName,
    String? iconLink,
    int? price,
    required int count,
  }) = _TaskRewardItemUiModel;
}

@freezed
abstract class TaskRewardStandingUiModel with _$TaskRewardStandingUiModel {
  const factory TaskRewardStandingUiModel({
    required String traderName,
    required double standing,
  }) = _TaskRewardStandingUiModel;
}

@freezed
abstract class TaskUiModel with _$TaskUiModel {
  const factory TaskUiModel({
    required String id,
    required String name,
    required String traderName,
    required String traderNormalizedName,
    String? traderImageLink,
    String? mapName,
    @Default(false) bool kappaRequired,
    required int experience,
    int? minPlayerLevel,
    String? taskImageLink,
    String? wikiLink,
    @Default([]) List<TaskObjectiveUiModel> objectives,
    @Default([]) List<String> prerequisiteTaskNames,
    @Default([]) List<TaskRewardItemUiModel> rewardItems,
    @Default([]) List<TaskRewardStandingUiModel> rewardStanding,
  }) = _TaskUiModel;
}
