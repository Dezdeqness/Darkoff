import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/bosses/model/boss_list_ui_model.dart';
import 'package:flutter/material.dart';

class BossCard extends StatelessWidget {
  const BossCard({super.key, required this.boss});
  final BossListItemUiModel boss;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: shape.radiusMD,
      ),
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () => context.router.push(BossDetailRoute(bossId: boss.id)),
        child: Container(
          decoration: BoxDecoration(color: colors.goldSubtle.withAlpha(80)),
          child: Row(
            children: [
              SizedBox(
                width: 72,
                height: 90,
                child: boss.portraitUrl != null
                    ? Image.network(
                        boss.portraitUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (ctx, e, st) => Center(
                          child: Icon(
                            Icons.shield_outlined,
                            color: colors.gold,
                            size: 28,
                          ),
                        ),
                      )
                    : Center(
                        child: Icon(
                          Icons.shield_outlined,
                          color: colors.gold,
                          size: 28,
                        ),
                      ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      boss.name,
                      style: typo.labelLarge.copyWith(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (boss.healthLabel != null) ...[
                      Text(
                        boss.healthLabel!,
                        style: typo.paragraphSmall.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                    _MapChips(names: boss.mapLabels),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.chevron_right,
                  color: colors.textTertiary,
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapChips extends StatelessWidget {
  const _MapChips({required this.names});
  final List<String> names;

  static const int _maxVisible = 2;

  @override
  Widget build(BuildContext context) {
    if (names.isEmpty) return const SizedBox.shrink();

    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final style = typo.paragraphSmall.copyWith(
      color: colors.textSecondary,
      fontSize: 10,
    );

    final visible = names.take(_maxVisible).toList();
    final hidden = names.length - visible.length;

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: [
        for (final name in visible) _chip(context, name, style),
        if (hidden > 0)
          _chip(context, '+$hidden', style.copyWith(color: colors.textTertiary)),
      ],
    );
  }

  Widget _chip(BuildContext context, String text, TextStyle style) {
    final colors = context.colorTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: colors.border),
      ),
      child: Text(text, style: style),
    );
  }
}
