import 'package:darkoff/presentation/features/boss_detail/model/boss_detail_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BossHealthGrid extends StatelessWidget {
  const BossHealthGrid({super.key, required this.parts});
  final List<BossBodyPartUiModel> parts;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: parts
            .map(
              (p) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: colors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      p.label,
                      style: typo.paragraphSmall.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      p.value,
                      style: typo.labelMedium.copyWith(
                        color: colors.gold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
