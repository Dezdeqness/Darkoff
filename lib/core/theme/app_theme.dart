import 'package:flutter/material.dart';

import 'themes/color_theme.dart';
import 'themes/shape_theme.dart';
import 'themes/sizing_theme.dart';
import 'themes/spacing_theme.dart';
import 'themes/typography_theme.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  AppTheme({
    required this.colorTheme,
    required this.typographyTheme,
    required this.spacingTheme,
    required this.sizingTheme,
    required this.shapeTheme,
  });

  final ThemeExtension<ColorTheme> colorTheme;
  final ThemeExtension<TypographyTheme> typographyTheme;
  final ThemeExtension<SpacingTheme> spacingTheme;
  final ThemeExtension<SizingTheme> sizingTheme;
  final ThemeExtension<ShapeTheme> shapeTheme;

  @override
  ThemeExtension<AppTheme> copyWith({
    ThemeExtension<ColorTheme>? colorTheme,
    ThemeExtension<TypographyTheme>? typographyTheme,
    ThemeExtension<SpacingTheme>? spacingTheme,
    ThemeExtension<SizingTheme>? sizingTheme,
    ThemeExtension<ShapeTheme>? shapeTheme,
  }) {
    return AppTheme(
      colorTheme: colorTheme ?? this.colorTheme,
      typographyTheme: typographyTheme ?? this.typographyTheme,
      spacingTheme: spacingTheme ?? this.spacingTheme,
      sizingTheme: sizingTheme ?? this.sizingTheme,
      shapeTheme: shapeTheme ?? this.shapeTheme,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) return this;

    return AppTheme(
      colorTheme: colorTheme.lerp(other.colorTheme, t),
      typographyTheme: typographyTheme.lerp(other.typographyTheme, t),
      spacingTheme: spacingTheme.lerp(other.spacingTheme, t),
      sizingTheme: sizingTheme.lerp(other.sizingTheme, t),
      shapeTheme: shapeTheme.lerp(other.shapeTheme, t),
    );
  }

  factory AppTheme.dark() {
    return AppTheme(
      colorTheme: ColorTheme.dark(),
      typographyTheme: TypographyTheme.standard(),
      spacingTheme: SpacingTheme.standard(),
      sizingTheme: SizingTheme.standard(),
      shapeTheme: ShapeTheme.standard(),
    );
  }

  factory AppTheme.light() => AppTheme.dark();
}
