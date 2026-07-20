import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_offers_state.freezed.dart';

@freezed
class TraderOffersState with _$TraderOffersState {
  const factory TraderOffersState.loading() = TraderOffersLoading;
  const factory TraderOffersState.error(String message) = TraderOffersError;
  const factory TraderOffersState.loaded({
    required List<TraderOfferUiModel> offers,
    @Default(<int>[]) List<int> levels,
    int? selectedLevel,
  }) = TraderOffersLoaded;
}
