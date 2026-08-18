import 'package:flutter/material.dart';

class ColorTheme extends ThemeExtension<ColorTheme> {
  const ColorTheme({
    required this.background,
    required this.surface,
    required this.surfaceHigh,

    required this.border,
    required this.borderStrong,
    required this.navBorder,

    required this.gold,
    required this.goldSubtle,

    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,

    required this.profit,
    required this.profitSubtle,
    required this.loss,
    required this.lossSubtle,

    required this.navBackground,
  });

  final Color background;
  final Color surface;
  final Color surfaceHigh;

  final Color border;
  final Color borderStrong;
  final Color navBorder;

  final Color gold;
  final Color goldSubtle;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;

  final Color profit;
  final Color profitSubtle;
  final Color loss;
  final Color lossSubtle;

  final Color navBackground;

  Border get activeChipBorder => Border.all(color: gold);

  Border get inactiveChipBorder => Border.all(color: borderStrong);

  factory ColorTheme.dark() {
    return const ColorTheme(
      background: Color(0xFF0D0D0D),
      surface: Color(0xFF1A1A1A),
      surfaceHigh: Color(0xFF252525),

      border: Color(0xFF252525),
      borderStrong: Color(0xFF2A2A2A),
      navBorder: Color(0xFF222222),

      gold: Color(0xFFC4A962),
      goldSubtle: Color(0x26C4A962),

      textPrimary: Color(0xFFE8E8E8),
      textSecondary: Color(0xFF888888),
      textTertiary: Color(0xFF666666),

      profit: Color(0xFF4A7C59),
      profitSubtle: Color(0x264A7C59),
      loss: Color(0xFF7C4A4A),
      lossSubtle: Color(0x267C4A4A),

      navBackground: Color(0xFF111111),
    );
  }

  @override
  ColorTheme copyWith({
    Color? background,
    Color? surface,
    Color? surfaceHigh,
    Color? border,
    Color? borderStrong,
    Color? navBorder,
    Color? gold,
    Color? goldSubtle,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? profit,
    Color? profitSubtle,
    Color? loss,
    Color? lossSubtle,
    Color? navBackground,
  }) {
    return ColorTheme(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceHigh: surfaceHigh ?? this.surfaceHigh,
      border: border ?? this.border,
      borderStrong: borderStrong ?? this.borderStrong,
      navBorder: navBorder ?? this.navBorder,
      gold: gold ?? this.gold,
      goldSubtle: goldSubtle ?? this.goldSubtle,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      profit: profit ?? this.profit,
      profitSubtle: profitSubtle ?? this.profitSubtle,
      loss: loss ?? this.loss,
      lossSubtle: lossSubtle ?? this.lossSubtle,
      navBackground: navBackground ?? this.navBackground,
    );
  }

  @override
  ColorTheme lerp(covariant ThemeExtension<ColorTheme>? other, double t) {
    if (other is! ColorTheme) return this;
    return ColorTheme(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      navBorder: Color.lerp(navBorder, other.navBorder, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      goldSubtle: Color.lerp(goldSubtle, other.goldSubtle, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      profit: Color.lerp(profit, other.profit, t)!,
      profitSubtle: Color.lerp(profitSubtle, other.profitSubtle, t)!,
      loss: Color.lerp(loss, other.loss, t)!,
      lossSubtle: Color.lerp(lossSubtle, other.lossSubtle, t)!,
      navBackground: Color.lerp(navBackground, other.navBackground, t)!,
    );
  }
}
