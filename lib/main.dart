import 'package:darkoff/core/localization/app_language.dart';
import 'package:darkoff/core/localization/app_translations.dart';
import 'package:darkoff/core/navigation/app_router.dart';
import 'package:darkoff/core/theme/app_theme.dart';
import 'package:darkoff/core/theme/app_theme_provider.dart';
import 'package:darkoff/core/theme/themes/color_theme.dart';
import 'package:darkoff/firebase_options.dart';
import 'package:darkoff/presentation/features/settings/notifiers/language_notifier.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/i18n_extension.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupServiceLocator();
  await AppTranslations.load();

  runApp(const ProviderScope(child: DarkoffApp()));
}

class DarkoffApp extends ConsumerStatefulWidget {
  const DarkoffApp({super.key});

  @override
  ConsumerState<DarkoffApp> createState() => _DarkoffAppState();
}

class _DarkoffAppState extends ConsumerState<DarkoffApp> {

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme.dark();
    final language = ref.watch(languageNotifierProvider);
    final locale = AppLanguage.toLocale(language);

    return AppThemeProvider(
      appTheme: AppTheme.dark(),
      child: I18n(
        initialLocale: locale,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),
          locale: locale,
          supportedLocales: AppLanguage.supportedUiLocales,
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: colors.background,
            colorScheme: ColorScheme.dark(
              surface: colors.surface,
              primary: colors.gold,
              onPrimary: colors.background,
              onSurface: colors.textPrimary,
              outline: colors.border,
            ),
            cardTheme: CardThemeData(
              color: colors.surface,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: colors.border),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            dividerColor: colors.border,
            extensions: [AppTheme.dark()],
          ),
        ),
      ),
    );
  }
}
