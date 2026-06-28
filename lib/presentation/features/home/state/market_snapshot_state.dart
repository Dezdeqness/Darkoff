import 'package:darkoff/presentation/features/home/model/market_item_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_snapshot_state.freezed.dart';

@freezed
class MarketSnapshotState with _$MarketSnapshotState {
  const factory MarketSnapshotState.initial() = MarketSnapshotInitial;
  const factory MarketSnapshotState.loading() = MarketSnapshotLoading;
  const factory MarketSnapshotState.empty() = MarketSnapshotEmpty;
  const factory MarketSnapshotState.loaded(List<MarketItemUiModel> items) =
      MarketSnapshotLoaded;
  const factory MarketSnapshotState.error(String message) =
      MarketSnapshotError;
}
