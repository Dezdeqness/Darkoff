import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

final themeDirectory = WidgetbookCategory(
  name: 'Theme',
  children: [
    WidgetbookComponent(
      name: 'Colors',
      useCases: [
        WidgetbookUseCase(
          name: 'Color Palette',
          builder: (context) => _ColorPalette(),
        ),
      ],
    ),
    WidgetbookComponent(
      name: 'Typography',
      useCases: [
        WidgetbookUseCase(
          name: 'Type Scale',
          builder: (context) => _TypeScale(),
        ),
      ],
    ),
    WidgetbookComponent(
      name: 'Spacing',
      useCases: [
        WidgetbookUseCase(
          name: 'Spacing Scale',
          builder: (context) => _SpacingScale(),
        ),
      ],
    ),
  ],
);

class _ColorPalette extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final items = <(String, Color)>[
      ('background', colors.background),
      ('surface', colors.surface),
      ('surfaceHigh', colors.surfaceHigh),
      ('border', colors.border),
      ('gold', colors.gold),
      ('goldSubtle', colors.goldSubtle),
      ('textPrimary', colors.textPrimary),
      ('textSecondary', colors.textSecondary),
      ('textTertiary', colors.textTertiary),
      ('profit', colors.profit),
      ('loss', colors.loss),
      ('navBackground', colors.navBackground),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: item.$2,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colors.border),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.$1,
                      style: TextStyle(
                        color: colors.gold,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      '#${item.$2.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
                      style: TextStyle(
                        color: colors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _TypeScale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final typo = context.typographyTheme;
    final colors = context.colorTheme;

    final styles = <(String, TextStyle)>[
      ('titleLarge (28 bold)', typo.titleLarge),
      ('titleMedium (22 w600)', typo.titleMedium),
      ('titleSmall (18 w500)', typo.titleSmall),
      ('bodyLarge (16)', typo.bodyLarge),
      ('bodyMedium (14)', typo.bodyMedium),
      ('bodySmall (12)', typo.bodySmall),
      ('labelLarge (14 w500)', typo.labelLarge),
      ('labelMedium (12 w500)', typo.labelMedium),
      ('labelSmall (10 w500)', typo.labelSmall),
      ('paragraphLarge (14)', typo.paragraphLarge),
      ('paragraphMedium (12)', typo.paragraphMedium),
      ('paragraphSmall (10)', typo.paragraphSmall),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: styles.map((s) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.$1,
                style: TextStyle(
                  color: colors.gold,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'The quick brown fox jumps over the lazy dog',
                style: s.$2.copyWith(color: colors.textPrimary),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SpacingScale extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spacing = context.spacingTheme;
    final colors = context.colorTheme;

    final items = <(String, double)>[
      ('xxs', spacing.xxs),
      ('xs', spacing.xs),
      ('sm', spacing.sm),
      ('md', spacing.md),
      ('lg', spacing.lg),
      ('xl', spacing.xl),
      ('xxl', spacing.xxl),
      ('xxxl', spacing.xxxl),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Text(
                  item.$1,
                  style: TextStyle(
                    color: colors.gold,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: item.$2,
                height: 24,
                decoration: BoxDecoration(
                  color: colors.gold,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${item.$2.toInt()}px',
                style: TextStyle(
                  color: colors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
