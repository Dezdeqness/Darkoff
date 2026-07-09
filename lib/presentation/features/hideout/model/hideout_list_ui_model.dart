import 'package:freezed_annotation/freezed_annotation.dart';

part 'hideout_list_ui_model.freezed.dart';

@freezed
abstract class StationCardUiModel with _$StationCardUiModel {
  const factory StationCardUiModel({
    required String id,
    required String name,
    String? imageLink,
    required int totalLevels,
    required int builtLevels,
    required String metaText,
    required double progress,
    required bool fullyBuilt,
  }) = _StationCardUiModel;
}

@freezed
abstract class HideoutSummaryUiModel with _$HideoutSummaryUiModel {
  const factory HideoutSummaryUiModel({
    required String title,
    required String subtitle,
    String? displayCost,
  }) = _HideoutSummaryUiModel;
}

@freezed
abstract class ShoppingEntryUiModel with _$ShoppingEntryUiModel {
  const factory ShoppingEntryUiModel({
    required String title,
    required String subtitle,
    required bool enabled,
  }) = _ShoppingEntryUiModel;
}

@freezed
abstract class HideoutListUiModel with _$HideoutListUiModel {
  const factory HideoutListUiModel({
    required HideoutSummaryUiModel summary,
    required ShoppingEntryUiModel shoppingEntry,
    @Default([]) List<StationCardUiModel> stations,
  }) = _HideoutListUiModel;
}
