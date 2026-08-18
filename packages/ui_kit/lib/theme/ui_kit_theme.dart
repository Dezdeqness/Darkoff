import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'app_theme_provider.dart';

class UiKitTheme extends StatelessWidget {
  const UiKitTheme({
    super.key,
    required this.child,
    this.theme,
  });

  final Widget child;
  final AppTheme? theme;

  @override
  Widget build(BuildContext context) {
    return AppThemeProvider(
      appTheme: theme ?? AppTheme.dark(),
      child: child,
    );
  }
}
