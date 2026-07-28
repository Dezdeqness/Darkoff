import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/app_language.dart';
import 'package:darkoff/core/localization/app_translations.dart';
import 'package:darkoff/core/localization/language_code.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/settings/notifiers/language_notifier.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(title: Text('settings.title'.i18n)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'settings.language.title'.i18n.toUpperCase(),
              style: typo.labelMedium.copyWith(
                color: colors.gold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'settings.language.subtitle'.i18n,
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

  String _languageLabel(LanguageCode language) {
    final code = language.code;
    final key = 'settings.language.$code';
    final localized = key.i18n;
    return localized == key ? code.toUpperCase() : localized;
  }
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
