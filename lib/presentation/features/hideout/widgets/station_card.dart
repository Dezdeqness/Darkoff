import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:darkoff/core/widgets/item_icon.dart';
import 'package:darkoff/presentation/features/hideout/model/hideout_list_ui_model.dart';
import 'package:flutter/material.dart';

class StationCard extends StatelessWidget {
  const StationCard({super.key, required this.model});

  final StationCardUiModel model;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return AppCard(
      onTap: () =>
          context.router.push(HideoutDetailRoute(stationId: model.id)),
      child: Row(
        children: [
          ItemIcon(
            imageUrl: model.imageLink,
            fallbackIcon: Icons.home_work_outlined,
            size: 40,
            useGoldBackground: true,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: typo.labelLarge.copyWith(color: colors.textPrimary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(model.totalLevels, (i) {
                    final built = i < model.builtLevels;
                    return Container(
                      width: 14,
                      height: 3,
                      margin: const EdgeInsets.only(right: 3),
                      decoration: BoxDecoration(
                        color: built ? colors.gold : colors.borderStrong,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  model.metaText,
                  style: typo.paragraphSmall.copyWith(color: colors.textSecondary),
                ),
                if (!model.fullyBuilt) ...[
                  const SizedBox(height: 6),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: LinearProgressIndicator(
                      value: model.progress,
                      minHeight: 3,
                      backgroundColor: colors.borderStrong,
                      valueColor: AlwaysStoppedAnimation(colors.gold),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, color: colors.textTertiary, size: 18),
        ],
      ),
    );
  }
}
