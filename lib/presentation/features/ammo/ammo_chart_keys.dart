import 'package:flutter/widgets.dart';

abstract class AmmoChartKeys {
  static const Key loading = ValueKey('ammo_chart_loading');
  static const Key content = ValueKey('ammo_chart_content');
  static const Key empty = ValueKey('ammo_chart_empty');
  static const Key error = ValueKey('ammo_chart_error');
}
