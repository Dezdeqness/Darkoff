import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ammo_chart_ui_model.freezed.dart';

@freezed
abstract class AmmoChartUiModel with _$AmmoChartUiModel {
  const factory AmmoChartUiModel({
    @Default([]) List<AmmoChartRowUiModel> rows,
  }) = _AmmoChartUiModel;
}

@freezed
abstract class AmmoChartRowUiModel with _$AmmoChartRowUiModel {
  const factory AmmoChartRowUiModel({
    required String name,
    required String damage,
    required String penetration,
    required Color penColor,
    @Default(false) bool isTracer,
    @Default(false) bool highlighted,
  }) = _AmmoChartRowUiModel;
}
