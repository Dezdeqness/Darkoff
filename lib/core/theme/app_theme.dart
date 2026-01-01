import 'package:flutter/material.dart';

import 'themes/sizing_theme.dart';
import 'themes/spacing_theme.dart';
import 'themes/typography_theme.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  AppTheme({
    required this.typographyTheme,
    required this.spacingTheme,
    required this.sizingTheme,
  });

  final ThemeExtension<TypographyTheme> typographyTheme;
  final ThemeExtension<SpacingTheme> spacingTheme;
  final ThemeExtension<SizingTheme> sizingTheme;

  @override
  ThemeExtension<AppTheme> copyWith({
    ThemeExtension<TypographyTheme>? typographyTheme,
    ThemeExtension<SpacingTheme>? spacingTheme,
    ThemeExtension<SizingTheme>? sizingTheme,
  }) {
    return AppTheme(
      typographyTheme: typographyTheme ?? this.typographyTheme,
      spacingTheme: spacingTheme ?? this.spacingTheme,
      sizingTheme: sizingTheme ?? this.sizingTheme,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
    covariant ThemeExtension<AppTheme>? other,
    double t,
  ) {
    if (other is! AppTheme) {
      return this;
    }

    return AppTheme(
      typographyTheme: typographyTheme.lerp(
        other.typographyTheme,
        t,
      ),
      spacingTheme: spacingTheme.lerp(
        other.spacingTheme,
        t,
      ),
      sizingTheme: sizingTheme.lerp(
        other.sizingTheme,
        t,
      ),
    );
  }

  factory AppTheme.light() {
    return AppTheme(
      typographyTheme: TypographyTheme.standard(),
      spacingTheme: SpacingTheme.standard(),
      sizingTheme: SizingTheme.standard(),
    );
  }

  factory AppTheme.dark() {
    return AppTheme(
      typographyTheme: TypographyTheme.standard(),
      spacingTheme: SpacingTheme.standard(),
      sizingTheme: SizingTheme.standard(),
    );
  }
}
