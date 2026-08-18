import 'dart:ui';

import 'package:ui_kit/theme/themes/color_theme.dart';

enum PropertyValueType { positive, negative, accent, normal }

Color parseHexColor(String colorString, {Color fallback = const Color(0xFF9E9E9E)}) {
  try {
    if (colorString.startsWith('#')) {
      return Color(
        int.parse(colorString.substring(1), radix: 16) + 0xFF000000,
      );
    }
    return fallback;
  } catch (_) {
    return fallback;
  }
}

Color propertyColor(PropertyValueType type, ColorTheme colors) {
  switch (type) {
    case PropertyValueType.positive:
      return colors.profit;

    case PropertyValueType.negative:
      return colors.loss;

    case PropertyValueType.accent:
      return colors.gold;

    case PropertyValueType.normal:
      return colors.textPrimary;
  }
}
