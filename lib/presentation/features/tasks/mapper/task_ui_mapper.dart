import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:darkoff/presentation/features/tasks/model/task_ui_model.dart';

class TaskUiMapper {
  TaskUiModel fromEntity(TaskEntity entity) {
    return TaskUiModel(
      id: entity.id,
      name: entity.name,
      traderName: entity.traderName,
      traderNormalizedName: entity.traderNormalizedName,
      traderImageLink: entity.traderImageLink,
      mapName: entity.mapName,
      kappaRequired: entity.kappaRequired,
      experience: entity.experience,
      minPlayerLevel: entity.minPlayerLevel,
      taskImageLink: entity.taskImageLink,
      wikiLink: entity.wikiLink,
      objectives: entity.objectives
          .map(
            (o) => TaskObjectiveUiModel(
              description: o.description,
              type: o.type,
              optional: o.optional,
            ),
          )
          .toList(),
      prerequisiteTaskNames:
          entity.prerequisites.map((p) => p.taskName).toList(),
      rewardItems: entity.rewardItems
          .map(
            (r) => TaskRewardItemUiModel(
              name: r.name,
              shortName: r.shortName,
              iconLink: r.iconLink,
              price: r.price,
              count: r.count,
            ),
          )
          .toList(),
      rewardStanding: entity.rewardStanding
          .map(
            (s) => TaskRewardStandingUiModel(
              traderName: s.traderName,
              standing: s.standing,
            ),
          )
          .toList(),
    );
  }

  List<TaskUiModel> fromEntities(List<TaskEntity> entities) {
    return entities.map(fromEntity).toList();
  }
}
