import 'package:darkoff/presentation/features/home/model/price_change_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_changes_state.freezed.dart';

@freezed
class PriceChangesState with _$PriceChangesState {
  const factory PriceChangesState.initial() = PriceChangesInitial;
  const factory PriceChangesState.loading() = PriceChangesLoading;
  const factory PriceChangesState.empty() = PriceChangesEmpty;
  const factory PriceChangesState.loaded(List<PriceChangeUiModel> items) =
      PriceChangesLoaded;
  const factory PriceChangesState.error(String message) = PriceChangesError;
}
