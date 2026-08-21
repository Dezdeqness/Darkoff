import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/app_language.dart';
import 'package:darkoff/core/localization/language_code.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/settings/notifiers/language_notifier.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;
    final current = ref.watch(languageNotifierProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(title: Text(tr.settings.title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              tr.settings.language.title.toUpperCase(),
              style: typo.labelMedium.copyWith(
                color: colors.gold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tr.settings.language.subtitle,
              style: typo.bodySmall.copyWith(color: colors.textSecondary),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border.all(color: colors.border),
                borderRadius: shape.radiusMD,
              ),
              child: Column(
                children: AppLanguage.supported.asMap().entries.map((entry) {
                  final language = entry.value;
                  final isLast = entry.key == AppLanguage.supported.length - 1;
                  return _LanguageRow(
                    label: _languageLabel(language),
                    selected: language == current,
                    showDivider: !isLast,
                    onTap: () => _selectLanguage(context, ref, language),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectLanguage(
    BuildContext context,
    WidgetRef ref,
    LanguageCode language,
  ) async {
    final notifier = ref.read(languageNotifierProvider.notifier);
    if (language == ref.read(languageNotifierProvider)) return;

    await notifier.setLanguage(language);

    if (context.mounted) {
      context.router.replaceAll([const SplashRoute()]);
    }
  }

  String _languageLabel(LanguageCode language) => switch (language) {
        LanguageCode.en => tr.settings.language.en,
        LanguageCode.ru => tr.settings.language.ru,
        LanguageCode.de => tr.settings.language.de,
        LanguageCode.fr => tr.settings.language.fr,
        LanguageCode.es => tr.settings.language.es,
        LanguageCode.zh => tr.settings.language.zh,
        _ => language.code.toUpperCase(),
      };
}

class _LanguageRow extends StatelessWidget {
  const _LanguageRow({
    required this.label,
    required this.selected,
    required this.showDivider,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool showDivider;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: showDivider
            ? BoxDecoration(
                border: Border(bottom: BorderSide(color: colors.border)),
              )
            : null,
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: typo.labelLarge.copyWith(color: colors.textPrimary),
              ),
            ),
            if (selected) Icon(Icons.check, color: colors.gold, size: 20),
          ],
        ),
      ),
    );
  }
}
