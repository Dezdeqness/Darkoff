import 'package:darkoff/core/utils/sizing.dart';
import 'package:flutter/material.dart';

class ShapeTheme extends ThemeExtension<ShapeTheme> {
  const ShapeTheme({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  BorderRadius get radiusXS => BorderRadius.circular(xs);
  BorderRadius get radiusSM => BorderRadius.circular(sm);
  BorderRadius get radiusMD => BorderRadius.circular(md);
  BorderRadius get radiusLG => BorderRadius.circular(lg);
  BorderRadius get radiusXL => BorderRadius.circular(xl);

  BorderRadius get radiusTopMD =>
      BorderRadius.vertical(top: Radius.circular(md));
  BorderRadius get radiusTopLG =>
      BorderRadius.vertical(top: Radius.circular(lg));
  BorderRadius get radiusTopXL =>
      BorderRadius.vertical(top: Radius.circular(xl));

  RoundedRectangleBorder get shapeXS =>
      RoundedRectangleBorder(borderRadius: radiusXS);
  RoundedRectangleBorder get shapeSM =>
      RoundedRectangleBorder(borderRadius: radiusSM);
  RoundedRectangleBorder get shapeMD =>
      RoundedRectangleBorder(borderRadius: radiusMD);
  RoundedRectangleBorder get shapeLG =>
      RoundedRectangleBorder(borderRadius: radiusLG);
  RoundedRectangleBorder get shapeXL =>
      RoundedRectangleBorder(borderRadius: radiusXL);

  @override
  ShapeTheme copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return ShapeTheme(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  ShapeTheme lerp(
    covariant ThemeExtension<ShapeTheme>? other,
    double t,
  ) {
    if (other is! ShapeTheme) return this;
    return ShapeTheme(
      xs: lerpDouble(xs, other.xs, t)!,
      sm: lerpDouble(sm, other.sm, t)!,
      md: lerpDouble(md, other.md, t)!,
      lg: lerpDouble(lg, other.lg, t)!,
      xl: lerpDouble(xl, other.xl, t)!,
    );
  }

  factory ShapeTheme.standard() {
    return const ShapeTheme(
      xs: 4.0,
      sm: 8.0,
      md: 12.0,
      lg: 16.0,
      xl: 24.0,
    );
  }
}
