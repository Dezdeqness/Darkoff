import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_detail_state.freezed.dart';

@freezed
class TraderDetailState with _$TraderDetailState {
  const factory TraderDetailState.loading() = TraderDetailLoading;
  const factory TraderDetailState.loaded(TraderDetailUiModel model) =
      TraderDetailLoaded;
  const factory TraderDetailState.error(String message) = TraderDetailError;
}
