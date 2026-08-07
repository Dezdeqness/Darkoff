import 'package:darkoff/core/localization/strings.g.dart';
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
          ? tr.taskDetail.experienceLabel(amount: entity.experience)
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
                  ? tr.taskDetail.reward.priceEach(price: formatPrice(r.price!))
                  : null,
              countLabel: tr.taskDetail.reward.count(count: r.count),
            ),
          )
          .toList(),
      rewardStanding: entity.rewardStanding
          .map(
            (s) => TaskRewardStandingUiModel(
              label: tr.taskDetail.reward.standing(
                trader: s.traderName,
                sign: s.standing > 0 ? '+' : '',
                amount: s.standing.toStringAsFixed(2),
              ),
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
          label: tr.taskDetail.meta.levelRequirement(
            level: entity.minPlayerLevel!,
          ),
          kind: TaskMetaKind.level,
        ),
      if (entity.mapName != null)
        TaskMetaUiModel(label: entity.mapName!, kind: TaskMetaKind.map),
      TaskMetaUiModel(
        label: tr.taskDetail.meta.experience(amount: entity.experience),
        kind: TaskMetaKind.experience,
      ),
    ];
  }
}
