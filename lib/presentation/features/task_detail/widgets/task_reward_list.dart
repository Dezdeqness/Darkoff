import 'package:darkoff/presentation/features/task_detail/model/task_detail_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class TaskRewardList extends StatelessWidget {
  const TaskRewardList({
    super.key,
    required this.experienceLabel,
    required this.items,
    required this.standing,
  });

  final String? experienceLabel;
  final List<TaskRewardItemUiModel> items;
  final List<TaskRewardStandingUiModel> standing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (experienceLabel != null)
          _RewardRow(
            icon: Icons.star_outline,
            label: experienceLabel!,
            iconColor: colors.gold,
          ),

        ...standing.map(
          (s) => _RewardRow(
            icon: Icons.person_outline,
            label: s.label,
            iconColor: s.positive ? colors.profit : colors.loss,
          ),
        ),

        ...items.map((r) => _RewardItemRow(item: r)),
      ],
    );
  }
}

class _RewardRow extends StatelessWidget {
  const _RewardRow({
    required this.icon,
    required this.label,
    required this.iconColor,
  });
  final IconData icon;
  final String label;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 14, color: iconColor),
          const SizedBox(width: 8),
          Text(
            label,
            style: typo.paragraphSmall.copyWith(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }
}

class _RewardItemRow extends StatelessWidget {
  const _RewardItemRow({required this.item});
  final TaskRewardItemUiModel item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          ItemIcon(
            imageUrl: item.iconLink,
            fallbackIcon: Icons.inventory_2_outlined,
            size: 36,
          ),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.shortName,
                  style: typo.labelMedium.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (item.priceLabel != null)
                  Text(
                    item.priceLabel!,
                    style: typo.paragraphSmall.copyWith(
                      color: colors.textTertiary,
                    ),
                  ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              item.countLabel,
              style: typo.labelMedium.copyWith(
                color: colors.gold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
