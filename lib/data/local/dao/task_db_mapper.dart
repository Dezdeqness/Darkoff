import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:drift/drift.dart';

class TaskDbMapper {
  TasksCompanion toTaskCompanion(TaskEntity task) {
    return TasksCompanion.insert(
      id: task.id,
      name: task.name,
      traderName: task.traderName,
      traderNormalizedName: task.traderNormalizedName,
      traderImageLink: Value(task.traderImageLink),
      mapName: Value(task.mapName),
      kappaRequired: Value(task.kappaRequired),
      experience: Value(task.experience),
      minPlayerLevel: Value(task.minPlayerLevel),
      taskImageLink: Value(task.taskImageLink),
      wikiLink: Value(task.wikiLink),
    );
  }

  TaskObjectivesCompanion toObjectiveCompanion(
    String taskId,
    TaskObjectiveEntity objective,
  ) {
    return TaskObjectivesCompanion.insert(
      taskId: taskId,
      description: objective.description,
      type: objective.type,
      optional: Value(objective.optional),
    );
  }

  TaskPrerequisitesCompanion toPrerequisiteCompanion(
    String taskId,
    TaskPrerequisiteEntity prerequisite,
  ) {
    return TaskPrerequisitesCompanion.insert(
      taskId: taskId,
      prerequisiteTaskId: prerequisite.taskId,
      prerequisiteTaskName: prerequisite.taskName,
    );
  }

  TaskRewardItemsCompanion toRewardItemCompanion(
    String taskId,
    TaskRewardItemEntity reward,
  ) {
    return TaskRewardItemsCompanion.insert(
      taskId: taskId,
      itemId: reward.id,
      name: reward.name,
      shortName: reward.shortName,
      iconLink: Value(reward.iconLink),
      price: Value(reward.price),
      count: Value(reward.count),
    );
  }

  TaskRewardStandingsCompanion toRewardStandingCompanion(
    String taskId,
    TaskRewardStandingEntity standing,
  ) {
    return TaskRewardStandingsCompanion.insert(
      taskId: taskId,
      traderName: standing.traderName,
      standing: standing.standing,
    );
  }

  TaskEntity toTaskEntity(
    Task row, {
    required List<TaskObjective> objectives,
    required List<TaskPrerequisite> prerequisites,
    required List<TaskRewardItem> rewardItems,
    required List<TaskRewardStanding> rewardStanding,
  }) {
    return TaskEntity(
      id: row.id,
      name: row.name,
      traderName: row.traderName,
      traderNormalizedName: row.traderNormalizedName,
      traderImageLink: row.traderImageLink,
      mapName: row.mapName,
      kappaRequired: row.kappaRequired,
      experience: row.experience,
      minPlayerLevel: row.minPlayerLevel,
      taskImageLink: row.taskImageLink,
      wikiLink: row.wikiLink,
      objectives: objectives
          .map(
            (o) => TaskObjectiveEntity(
              description: o.description,
              type: o.type,
              optional: o.optional,
            ),
          )
          .toList(),
      prerequisites: prerequisites
          .map(
            (p) => TaskPrerequisiteEntity(
              taskId: p.prerequisiteTaskId,
              taskName: p.prerequisiteTaskName,
            ),
          )
          .toList(),
      rewardItems: rewardItems
          .map(
            (r) => TaskRewardItemEntity(
              id: r.itemId,
              name: r.name,
              shortName: r.shortName,
              iconLink: r.iconLink,
              price: r.price,
              count: r.count,
            ),
          )
          .toList(),
      rewardStanding: rewardStanding
          .map(
            (s) => TaskRewardStandingEntity(
              traderName: s.traderName,
              standing: s.standing,
            ),
          )
          .toList(),
    );
  }
}
