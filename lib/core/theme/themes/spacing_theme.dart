import 'package:darkoff/core/utils/sizing.dart';
import 'package:flutter/material.dart';

class SpacingTheme extends ThemeExtension<SpacingTheme> {
  const SpacingTheme({
    required this.xxs,
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
    required this.xxxl,
  });

  final double xxs;
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;
  final double xxxl;

  EdgeInsets get allXXS => EdgeInsets.all(xxs);
  EdgeInsets get allXS => EdgeInsets.all(xs);
  EdgeInsets get allSM => EdgeInsets.all(sm);
  EdgeInsets get allMD => EdgeInsets.all(md);
  EdgeInsets get allLG => EdgeInsets.all(lg);
  EdgeInsets get allXL => EdgeInsets.all(xl);
  EdgeInsets get allXXL => EdgeInsets.all(xxl);
  EdgeInsets get allXXXL => EdgeInsets.all(xxxl);

  EdgeInsets get horizontalXXS => EdgeInsets.symmetric(horizontal: xxs);
  EdgeInsets get horizontalXS => EdgeInsets.symmetric(horizontal: xs);
  EdgeInsets get horizontalSM => EdgeInsets.symmetric(horizontal: sm);
  EdgeInsets get horizontalMD => EdgeInsets.symmetric(horizontal: md);
  EdgeInsets get horizontalLG => EdgeInsets.symmetric(horizontal: lg);
  EdgeInsets get horizontalXL => EdgeInsets.symmetric(horizontal: xl);
  EdgeInsets get horizontalXXL => EdgeInsets.symmetric(horizontal: xxl);
  EdgeInsets get horizontalXXXL => EdgeInsets.symmetric(horizontal: xxxl);

  EdgeInsets get verticalXXS => EdgeInsets.symmetric(vertical: xxs);
  EdgeInsets get verticalXS => EdgeInsets.symmetric(vertical: xs);
  EdgeInsets get verticalSM => EdgeInsets.symmetric(vertical: sm);
  EdgeInsets get verticalMD => EdgeInsets.symmetric(vertical: md);
  EdgeInsets get verticalLG => EdgeInsets.symmetric(vertical: lg);
  EdgeInsets get verticalXL => EdgeInsets.symmetric(vertical: xl);
  EdgeInsets get verticalXXL => EdgeInsets.symmetric(vertical: xxl);
  EdgeInsets get verticalXXXL => EdgeInsets.symmetric(vertical: xxxl);

  SizedBox get gapXXS => SizedBox(width: xxs, height: xxs);
  SizedBox get gapXS => SizedBox(width: xs, height: xs);
  SizedBox get gapSM => SizedBox(width: sm, height: sm);
  SizedBox get gapMD => SizedBox(width: md, height: md);
  SizedBox get gapLG => SizedBox(width: lg, height: lg);
  SizedBox get gapXL => SizedBox(width: xl, height: xl);
  SizedBox get gapXXL => SizedBox(width: xxl, height: xxl);
  SizedBox get gapXXXL => SizedBox(width: xxxl, height: xxxl);

  EdgeInsets symmetric({double? horizontal, double? vertical}) {
    return EdgeInsets.symmetric(
      horizontal: horizontal ?? 0,
      vertical: vertical ?? 0,
    );
  }

  EdgeInsets only({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: left ?? 0,
      top: top ?? 0,
      right: right ?? 0,
      bottom: bottom ?? 0,
    );
  }

  @override
  ThemeExtension<SpacingTheme> copyWith({
    double? xxs,
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
    double? xxxl,
  }) {
    return SpacingTheme(
      xxs: xxs ?? this.xxs,
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
      xxxl: xxxl ?? this.xxxl,
    );
  }

  @override
  ThemeExtension<SpacingTheme> lerp(
    covariant ThemeExtension<SpacingTheme>? other,
    double t,
  ) {
    if (other is! SpacingTheme) {
      return this;
    }

    return SpacingTheme(
      xxs: lerpDouble(xxs, other.xxs, t)!,
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
      xxl: lerpDouble(xxl, other.xxl, t)!,
      xxxl: lerpDouble(xxxl, other.xxxl, t)!,
    );
  }

  factory SpacingTheme.standard() {
    return const SpacingTheme(
      xxs: 2.0,
      xs: 4.0,
      sm: 8.0,
      md: 12.0,
      lg: 16.0,
      xl: 20.0,
      xxl: 24.0,
      xxxl: 32.0,
    );
  }
}
