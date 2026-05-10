import 'package:darkoff/core/navigation/app_router.dart';
import 'package:darkoff/core/theme/app_theme.dart';
import 'package:darkoff/core/theme/app_theme_provider.dart';
import 'package:darkoff/core/theme/themes/color_theme.dart';
import 'package:darkoff/service_locator/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupServiceLocator();

  runApp(const ProviderScope(child: DarkoffApp()));
}

class DarkoffApp extends StatelessWidget {
  const DarkoffApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = ColorTheme.dark();

    return AppThemeProvider(
      appTheme: AppTheme.dark(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter().config(),
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
