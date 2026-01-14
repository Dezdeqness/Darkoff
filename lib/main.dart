import 'package:darkoff/core/navigation/app_router.dart';
import 'package:darkoff/core/theme/app_theme.dart';
import 'package:darkoff/core/theme/app_theme_provider.dart';
import 'package:darkoff/service_locator/categories_service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  setupCategoriesServiceLocator();

  runApp(const ProviderScope(child: DarkoffApp()));
}

class DarkoffApp extends StatelessWidget {
  const DarkoffApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppThemeProvider(
      appTheme: AppTheme.light(),
      child: Builder(builder: (context) {
        final theme = AppThemeProvider.of(context);

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter().config(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            extensions: [theme.appTheme],
          ),
        );
      }),
    );
  }
}
