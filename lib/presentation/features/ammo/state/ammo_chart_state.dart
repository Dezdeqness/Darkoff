import 'package:darkoff/presentation/features/ammo/model/ammo_chart_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ammo_chart_state.freezed.dart';

@freezed
class AmmoChartState with _$AmmoChartState {
  const factory AmmoChartState.initial() = AmmoChartInitial;
  const factory AmmoChartState.loading() = AmmoChartLoading;
  const factory AmmoChartState.loaded(AmmoChartUiModel chart) = AmmoChartLoaded;
  const factory AmmoChartState.error(String message) = AmmoChartError;
}
