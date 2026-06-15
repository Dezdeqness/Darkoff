import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:darkoff/presentation/features/task_detail/model/task_detail_ui_model.dart';

class TaskDetailUiMapper {
  TaskDetailUiModel fromEntity(TaskEntity entity) {
    return TaskDetailUiModel(
      id: entity.id,
      name: entity.name,
      traderName: entity.traderName,
      traderImageLink: entity.traderImageLink,
      taskImageLink: entity.taskImageLink,
      kappaRequired: entity.kappaRequired,
      meta: _buildMeta(entity),
      experienceLabel: entity.experience > 0
          ? '${entity.experience} EXP'
          : null,
      prerequisiteTaskNames: entity.prerequisites
          .map((p) => p.taskName)
          .toList(),
      objectives: entity.objectives
          .map(
            (o) => TaskObjectiveUiModel(
              description: o.description,
              optional: o.optional,
            ),
          )
          .toList(),
      rewardItems: entity.rewardItems
          .map(
            (r) => TaskRewardItemUiModel(
              shortName: r.shortName,
              iconLink: r.iconLink,
              priceLabel: r.price != null
                  ? '${formatPrice(r.price!)} ₽ each'
                  : null,
              countLabel: '× ${r.count}',
            ),
          )
          .toList(),
      rewardStanding: entity.rewardStanding
          .map(
            (s) => TaskRewardStandingUiModel(
              label:
                  '${s.traderName}: ${s.standing > 0 ? '+' : ''}'
                  '${s.standing.toStringAsFixed(2)} reputation',
              positive: s.standing >= 0,
            ),
          )
          .toList(),
    );
  }

  List<TaskMetaUiModel> _buildMeta(TaskEntity entity) {
    return [
      if (entity.minPlayerLevel != null)
        TaskMetaUiModel(
          label: 'Level ${entity.minPlayerLevel}+',
          kind: TaskMetaKind.level,
        ),
      if (entity.mapName != null)
        TaskMetaUiModel(label: entity.mapName!, kind: TaskMetaKind.map),
      TaskMetaUiModel(
        label: '${entity.experience} XP',
        kind: TaskMetaKind.experience,
      ),
    ];
  }
}
