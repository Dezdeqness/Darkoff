import 'package:darkoff/data/models/item_api.dart' show ContainedRefApi;
import 'package:json_annotation/json_annotation.dart';

part 'task_api.g.dart';

@JsonSerializable(createToJson: false)
class TaskApi {
  const TaskApi({
    required this.id,
    this.name,
    this.normalizedName,
    this.trader,
    this.map,
    this.minPlayerLevel,
    this.experience,
    this.kappaRequired,
    this.taskImageLink,
    this.wikiLink,
    this.objectives = const [],
    this.taskRequirements = const [],
    this.finishRewards,
  });

  factory TaskApi.fromJson(Map<String, dynamic> json) =>
      _$TaskApiFromJson(json);

  final String id;
  final String? name;
  final String? normalizedName;
  final String? trader;
  final String? map;
  final int? minPlayerLevel;
  final int? experience;
  final bool? kappaRequired;
  final String? taskImageLink;
  final String? wikiLink;
  final List<TaskObjectiveApi> objectives;
  final List<TaskRequirementApi> taskRequirements;
  final TaskRewardsApi? finishRewards;
}

@JsonSerializable(createToJson: false)
class TaskObjectiveApi {
  const TaskObjectiveApi({this.id, this.description, this.type, this.optional});

  factory TaskObjectiveApi.fromJson(Map<String, dynamic> json) =>
      _$TaskObjectiveApiFromJson(json);

  final String? id;
  final String? description;
  final String? type;
  final bool? optional;
}

@JsonSerializable(createToJson: false)
class TaskRequirementApi {
  const TaskRequirementApi({this.task});

  factory TaskRequirementApi.fromJson(Map<String, dynamic> json) =>
      _$TaskRequirementApiFromJson(json);

  final String? task;
}

@JsonSerializable(createToJson: false)
class TaskRewardsApi {
  const TaskRewardsApi({this.items = const [], this.traderStanding = const []});

  factory TaskRewardsApi.fromJson(Map<String, dynamic> json) =>
      _$TaskRewardsApiFromJson(json);

  final List<ContainedRefApi> items;
  final List<TaskStandingApi> traderStanding;
}

@JsonSerializable(createToJson: false)
class TaskStandingApi {
  const TaskStandingApi({this.trader, this.standing});

  factory TaskStandingApi.fromJson(Map<String, dynamic> json) =>
      _$TaskStandingApiFromJson(json);

  final String? trader;
  final num? standing;
}
