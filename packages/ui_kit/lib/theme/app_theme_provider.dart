import 'package:ui_kit/theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppThemeProvider extends InheritedWidget {
  const AppThemeProvider({
    required this.appTheme,
    required super.child,
    super.key,
  });

  final AppTheme appTheme;

  @override
  bool updateShouldNotify(AppThemeProvider oldWidget) =>
      oldWidget.appTheme != appTheme;

  static AppThemeProvider of(BuildContext context) {
    final themeProvider = context
        .dependOnInheritedWidgetOfExactType<AppThemeProvider>();
    if (themeProvider == null) {
      throw Exception('No AppThemeProvider found in the widget tree');
    }

    return themeProvider;
  }
}
