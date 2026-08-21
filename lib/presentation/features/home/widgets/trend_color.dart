import 'package:darkoff/presentation/features/home/model/price_change_ui_model.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

extension PriceTrendColor on PriceTrend {
  Color color(ColorTheme colors) => switch (this) {
        PriceTrend.up => colors.profit,
        PriceTrend.down => colors.loss,
        PriceTrend.flat => colors.textSecondary,
      };

  Color subtleColor(ColorTheme colors) => switch (this) {
        PriceTrend.up => colors.profitSubtle,
        PriceTrend.down => colors.lossSubtle,
        PriceTrend.flat => colors.surfaceHigh,
      };
}
