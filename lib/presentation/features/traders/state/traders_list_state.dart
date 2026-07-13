import 'package:darkoff/presentation/features/traders/model/trader_list_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'traders_list_state.freezed.dart';

@freezed
class TradersListState with _$TradersListState {
  const factory TradersListState.loading() = TradersListLoading;
  const factory TradersListState.loaded(List<TraderListItemUiModel> traders) =
      TradersListLoaded;
  const factory TradersListState.error(String message) = TradersListError;
}
