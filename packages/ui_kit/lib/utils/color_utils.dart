import 'dart:ui';

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
