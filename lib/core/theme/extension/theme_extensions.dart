import 'package:darkoff/core/theme/app_theme.dart';
import 'package:darkoff/core/theme/themes/sizing_theme.dart';
import 'package:darkoff/core/theme/themes/spacing_theme.dart';
import 'package:darkoff/core/theme/themes/typography_theme.dart';
import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TypographyTheme get typographyTheme =>
      theme.appTheme.typographyTheme as TypographyTheme;

  SpacingTheme get spacingTheme => theme.appTheme.spacingTheme as SpacingTheme;

  SizingTheme get sizingTheme => theme.appTheme.sizingTheme as SizingTheme;
}

extension ThemeDataExtension on ThemeData {
  AppTheme get appTheme {
    final ext = extension<AppTheme>();
    assert(ext != null, 'AppTheme is not found in ThemeData');
    return ext!;
  }
}
