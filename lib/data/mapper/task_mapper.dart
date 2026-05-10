import 'package:darkoff/data/service/qraphql/queries/tasks.graphql.dart';
import 'package:darkoff/domain/entities/task_entity.dart';

class TaskMapper {
  TaskEntity fromGraphql(Query$DarkoffTasks$tasks task) {
    final rewards = task.finishRewards;

    return TaskEntity(
      id: task.id ?? task.normalizedName,
      name: task.name,
      traderName: task.trader.name,
      traderNormalizedName: task.trader.normalizedName,
      traderImageLink: task.trader.imageLink,
      mapName: task.map?.name,
      kappaRequired: task.kappaRequired ?? false,
      experience: task.experience,
      minPlayerLevel: task.minPlayerLevel,
      taskImageLink: task.taskImageLink,
      wikiLink: task.wikiLink,
      objectives: task.objectives
          .whereType<Query$DarkoffTasks$tasks$objectives>()
          .map(
            (o) => TaskObjectiveEntity(
              description: o.description,
              type: o.type,
              optional: o.optional,
            ),
          )
          .toList(),
      prerequisites: task.taskRequirements
          .whereType<Query$DarkoffTasks$tasks$taskRequirements>()
          .map(
            (r) => TaskPrerequisiteEntity(
              taskId: r.task.id ?? '',
              taskName: r.task.name,
            ),
          )
          .toList(),
      rewardItems: rewards == null
          ? []
          : rewards.items
              .whereType<Query$DarkoffTasks$tasks$finishRewards$items>()
              .map(
                (ci) => TaskRewardItemEntity(
                  id: ci.item.id,
                  name: ci.item.name ?? ci.item.shortName ?? '',
                  shortName: ci.item.shortName ?? ci.item.name ?? '',
                  iconLink: ci.item.iconLink,
                  price: ci.item.avg24hPrice,
                  count: ci.count.toInt(),
                ),
              )
              .toList(),
      rewardStanding: rewards == null
          ? []
          : rewards.traderStanding
              .whereType<
                  Query$DarkoffTasks$tasks$finishRewards$traderStanding>()
              .map(
                (ts) => TaskRewardStandingEntity(
                  traderName: ts.trader.name,
                  standing: ts.standing,
                ),
              )
              .toList(),
    );
  }
}
