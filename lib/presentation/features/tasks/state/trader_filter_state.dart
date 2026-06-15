import 'package:darkoff/presentation/features/tasks/model/trader_filter_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_filter_state.freezed.dart';

@freezed
abstract class TraderFilterState with _$TraderFilterState {
  const factory TraderFilterState({
    required List<TraderFilterUiModel> traders,
    @Default(0) int selectedIndex,
  }) = _TraderFilterState;
}
