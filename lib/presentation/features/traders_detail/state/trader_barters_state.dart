import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_barters_state.freezed.dart';

@freezed
class TraderBartersState with _$TraderBartersState {
  const factory TraderBartersState.loading() = TraderBartersLoading;
  const factory TraderBartersState.error(String message) = TraderBartersError;
  const factory TraderBartersState.loaded({
    required List<TraderBarterUiModel> barters,
    @Default(<int>[]) List<int> levels,
    int? selectedLevel,
  }) = TraderBartersLoaded;
}
