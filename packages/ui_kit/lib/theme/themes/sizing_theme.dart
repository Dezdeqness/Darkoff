import 'package:ui_kit/utils/lerp_double.dart';
import 'package:flutter/material.dart';

class SizingTheme extends ThemeExtension<SizingTheme> {
  const SizingTheme({
    required this.iconXS,
    required this.iconSM,
    required this.iconMD,
    required this.iconLG,
    required this.iconXL,
    required this.iconXXL,
    required this.radiusXS,
    required this.radiusSM,
    required this.radiusMD,
    required this.radiusLG,
    required this.radiusXL,
    required this.radiusXXL,
    required this.radiusFull,
    required this.buttonHeightSM,
    required this.buttonHeightMD,
    required this.buttonHeightLG,
    required this.buttonHeightXL,
    required this.borderWidthThin,
    required this.borderWidthMedium,
    required this.borderWidthThick,
  });

  final double iconXS;
  final double iconSM;
  final double iconMD;
  final double iconLG;
  final double iconXL;
  final double iconXXL;

  final double radiusXS;
  final double radiusSM;
  final double radiusMD;
  final double radiusLG;
  final double radiusXL;
  final double radiusXXL;
  final double radiusFull;

  final double buttonHeightSM;
  final double buttonHeightMD;
  final double buttonHeightLG;
  final double buttonHeightXL;

  final double borderWidthThin;
  final double borderWidthMedium;
  final double borderWidthThick;

  BorderRadius get borderRadiusXS => BorderRadius.circular(radiusXS);
  BorderRadius get borderRadiusSM => BorderRadius.circular(radiusSM);
  BorderRadius get borderRadiusMD => BorderRadius.circular(radiusMD);
  BorderRadius get borderRadiusLG => BorderRadius.circular(radiusLG);
  BorderRadius get borderRadiusXL => BorderRadius.circular(radiusXL);
  BorderRadius get borderRadiusXXL => BorderRadius.circular(radiusXXL);
  BorderRadius get borderRadiusFull => BorderRadius.circular(radiusFull);

  BorderRadius borderRadius(double radius) {
    return BorderRadius.circular(radius);
  }

  @override
  ThemeExtension<SizingTheme> copyWith({
    double? iconXS,
    double? iconSM,
    double? iconMD,
    double? iconLG,
    double? iconXL,
    double? iconXXL,
    double? radiusXS,
    double? radiusSM,
    double? radiusMD,
    double? radiusLG,
    double? radiusXL,
    double? radiusXXL,
    double? radiusFull,
    double? buttonHeightSM,
    double? buttonHeightMD,
    double? buttonHeightLG,
    double? buttonHeightXL,
    double? borderWidthThin,
    double? borderWidthMedium,
    double? borderWidthThick,
  }) {
    return SizingTheme(
      iconXS: iconXS ?? this.iconXS,
      iconSM: iconSM ?? this.iconSM,
      iconMD: iconMD ?? this.iconMD,
      iconLG: iconLG ?? this.iconLG,
      iconXL: iconXL ?? this.iconXL,
      iconXXL: iconXXL ?? this.iconXXL,
      radiusXS: radiusXS ?? this.radiusXS,
      radiusSM: radiusSM ?? this.radiusSM,
      radiusMD: radiusMD ?? this.radiusMD,
      radiusLG: radiusLG ?? this.radiusLG,
      radiusXL: radiusXL ?? this.radiusXL,
      radiusXXL: radiusXXL ?? this.radiusXXL,
      radiusFull: radiusFull ?? this.radiusFull,
      buttonHeightSM: buttonHeightSM ?? this.buttonHeightSM,
      buttonHeightMD: buttonHeightMD ?? this.buttonHeightMD,
      buttonHeightLG: buttonHeightLG ?? this.buttonHeightLG,
      buttonHeightXL: buttonHeightXL ?? this.buttonHeightXL,
      borderWidthThin: borderWidthThin ?? this.borderWidthThin,
      borderWidthMedium: borderWidthMedium ?? this.borderWidthMedium,
      borderWidthThick: borderWidthThick ?? this.borderWidthThick,
    );
  }

  @override
  ThemeExtension<SizingTheme> lerp(
    covariant ThemeExtension<SizingTheme>? other,
    double t,
  ) {
    if (other is! SizingTheme) {
      return this;
    }

    return SizingTheme(
      iconXS: lerpDouble(iconXS, other.iconXS, t)!,
      iconSM: lerpDouble(iconSM, other.iconSM, t)!,
      iconMD: lerpDouble(iconMD, other.iconMD, t)!,
      iconLG: lerpDouble(iconLG, other.iconLG, t)!,
      iconXL: lerpDouble(iconXL, other.iconXL, t)!,
      iconXXL: lerpDouble(iconXXL, other.iconXXL, t)!,
      radiusXS: lerpDouble(radiusXS, other.radiusXS, t)!,
      radiusSM: lerpDouble(radiusSM, other.radiusSM, t)!,
      radiusMD: lerpDouble(radiusMD, other.radiusMD, t)!,
      radiusLG: lerpDouble(radiusLG, other.radiusLG, t)!,
      radiusXL: lerpDouble(radiusXL, other.radiusXL, t)!,
      radiusXXL: lerpDouble(radiusXXL, other.radiusXXL, t)!,
      radiusFull: lerpDouble(radiusFull, other.radiusFull, t)!,
      buttonHeightSM: lerpDouble(buttonHeightSM, other.buttonHeightSM, t)!,
      buttonHeightMD: lerpDouble(buttonHeightMD, other.buttonHeightMD, t)!,
      buttonHeightLG: lerpDouble(buttonHeightLG, other.buttonHeightLG, t)!,
      buttonHeightXL: lerpDouble(buttonHeightXL, other.buttonHeightXL, t)!,
      borderWidthThin: lerpDouble(borderWidthThin, other.borderWidthThin, t)!,
      borderWidthMedium: lerpDouble(borderWidthMedium, other.borderWidthMedium, t)!,
      borderWidthThick: lerpDouble(borderWidthThick, other.borderWidthThick, t)!,
    );
  }

  factory SizingTheme.standard() {
    return const SizingTheme(
      iconXS: 12.0,
      iconSM: 16.0,
      iconMD: 20.0,
      iconLG: 24.0,
      iconXL: 32.0,
      iconXXL: 40.0,
      radiusXS: 4.0,
      radiusSM: 6.0,
      radiusMD: 8.0,
      radiusLG: 12.0,
      radiusXL: 16.0,
      radiusXXL: 20.0,
      radiusFull: 9999.0,
      buttonHeightSM: 32.0,
      buttonHeightMD: 40.0,
      buttonHeightLG: 48.0,
      buttonHeightXL: 56.0,
      borderWidthThin: 1.0,
      borderWidthMedium: 1.5,
      borderWidthThick: 2.0,
    );
  }
}
