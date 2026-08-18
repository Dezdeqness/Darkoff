import 'package:flutter/material.dart';

class TypographyTheme extends ThemeExtension<TypographyTheme> {
  const TypographyTheme({
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,

    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,

    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,

    required this.paragraphLarge,
    required this.paragraphMedium,
    required this.paragraphSmall,
  });

  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;

  final TextStyle bodyLarge;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;

  final TextStyle labelLarge;
  final TextStyle labelMedium;
  final TextStyle labelSmall;

  final TextStyle paragraphLarge;
  final TextStyle paragraphMedium;
  final TextStyle paragraphSmall;

  @override
  TypographyTheme copyWith({
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,

    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,

    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,

    TextStyle? paragraphLarge,
    TextStyle? paragraphMedium,
    TextStyle? paragraphSmall,
  }) {
    return TypographyTheme(
      titleLarge: titleLarge ?? this.titleLarge,
      titleMedium: titleMedium ?? this.titleMedium,
      titleSmall: titleSmall ?? this.titleSmall,

      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,

      labelLarge: labelLarge ?? this.labelLarge,
      labelMedium: labelMedium ?? this.labelMedium,
      labelSmall: labelSmall ?? this.labelSmall,

      paragraphLarge: paragraphLarge ?? this.paragraphLarge,
      paragraphMedium: paragraphMedium ?? this.paragraphMedium,
      paragraphSmall: paragraphSmall ?? this.paragraphSmall,
    );
  }

  @override
  TypographyTheme lerp(
    covariant ThemeExtension<TypographyTheme>? other,
    double t,
  ) {
    if (other is! TypographyTheme) return this;
    return TypographyTheme(
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,

      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,

      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,

      paragraphLarge: TextStyle.lerp(paragraphLarge, other.paragraphLarge, t)!,
      paragraphMedium: TextStyle.lerp(
        paragraphMedium,
        other.paragraphMedium,
        t,
      )!,
      paragraphSmall: TextStyle.lerp(paragraphSmall, other.paragraphSmall, t)!,
    );
  }

  factory TypographyTheme.standard() {
    return TypographyTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        height: 1.3,
        letterSpacing: 0.0,
      ),
      titleMedium: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      titleSmall: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        height: 1.4,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.35,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.3,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.3,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 1.25,
      ),
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),

      paragraphLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        height: 1.35,
      ),
      paragraphMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.normal,
        height: 1.3,
      ),
      paragraphSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.normal,
        height: 1.2,
      ),
    );
  }
}
