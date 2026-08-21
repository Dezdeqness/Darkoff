import 'dart:ui';

import 'package:darkoff/presentation/features/core/model/property_tile_ui_model.dart';
import 'package:ui_kit/ui_kit.dart';

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
