import 'package:darkoff/core/config/app_config.dart';
import 'package:darkoff/core/localization/app_language.dart';
import 'package:darkoff/core/localization/language_store.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/navigation/app_router.dart';
import 'package:darkoff/firebase_options.dart';
import 'package:darkoff/presentation/features/settings/notifiers/language_notifier.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError =
      FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );
    return true;
  };

  await setupServiceLocator();
  await LocaleSettings.setLocale(
    AppLanguage.toSlangLocale(getIt<LanguageStore>().language),
  );

  runApp(
    TranslationProvider(
      child: const ProviderScope(child: DarkoffApp()),
    ),
  );
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
    );
  }
}
