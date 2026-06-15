import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/task_detail/model/task_detail_ui_model.dart';
import 'package:flutter/material.dart';

class TaskObjectiveList extends StatelessWidget {
  const TaskObjectiveList({super.key, required this.objectives});

  final List<TaskObjectiveUiModel> objectives;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: objectives.map((o) => _ObjectiveRow(objective: o)).toList(),
    );
  }
}

class _ObjectiveRow extends StatelessWidget {
  const _ObjectiveRow({required this.objective});
  final TaskObjectiveUiModel objective;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                border: Border.all(color: colors.borderStrong, width: 1.5),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  objective.description,
                  style: typo.paragraphSmall.copyWith(
                    color: colors.textPrimary,
                  ),
                ),
                if (objective.optional)
                  Text(
                    'Optional',
                    style: typo.paragraphSmall.copyWith(
                      color: colors.textTertiary,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
