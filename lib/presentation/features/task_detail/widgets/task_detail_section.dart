import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_card.dart';
import 'package:flutter/material.dart';

class TaskDetailSection extends StatelessWidget {
  const TaskDetailSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return AppCard(
      clipContent: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.goldSubtle,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(shape.radiusMD.topLeft.x),
                topRight: Radius.circular(shape.radiusMD.topRight.x),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Text(
              title,
              style: typo.labelSmall.copyWith(
                color: colors.gold,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Padding(padding: const EdgeInsets.all(14), child: child),
        ],
      ),
    );
  }
}
