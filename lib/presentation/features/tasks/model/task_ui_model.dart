class TaskObjectiveUiModel {
  const TaskObjectiveUiModel({
    required this.description,
    required this.type,
    this.optional = false,
  });
  final String description;
  final String type;
  final bool optional;
}

class TaskRewardItemUiModel {
  const TaskRewardItemUiModel({
    required this.name,
    required this.shortName,
    this.iconLink,
    this.price,
    required this.count,
  });
  final String name;
  final String shortName;
  final String? iconLink;
  final int? price;
  final int count;
}

class TaskRewardStandingUiModel {
  const TaskRewardStandingUiModel({
    required this.traderName,
    required this.standing,
  });
  final String traderName;
  final double standing;
}

class TaskUiModel {
  const TaskUiModel({
    required this.id,
    required this.name,
    required this.traderName,
    required this.traderNormalizedName,
    this.traderImageLink,
    this.mapName,
    this.kappaRequired = false,
    required this.experience,
    this.minPlayerLevel,
    this.taskImageLink,
    this.wikiLink,
    this.objectives = const [],
    this.prerequisiteTaskNames = const [],
    this.rewardItems = const [],
    this.rewardStanding = const [],
  });

  final String id;
  final String name;
  final String traderName;
  final String traderNormalizedName;
  final String? traderImageLink;
  final String? mapName;
  final bool kappaRequired;
  final int experience;
  final int? minPlayerLevel;
  final String? taskImageLink;
  final String? wikiLink;
  final List<TaskObjectiveUiModel> objectives;
  final List<String> prerequisiteTaskNames;
  final List<TaskRewardItemUiModel> rewardItems;
  final List<TaskRewardStandingUiModel> rewardStanding;
}
