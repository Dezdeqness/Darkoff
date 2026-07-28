import 'package:freezed_annotation/freezed_annotation.dart';

part 'crafts_list_ui_model.freezed.dart';

enum CraftSort { profitPerHour, totalProfit }

@freezed
abstract class CraftsListUiModel with _$CraftsListUiModel {
  const factory CraftsListUiModel({
    @Default([]) List<CraftStationOption> stations,
    @Default('') String sortLabel,
    @Default([]) List<CraftRowUiModel> rows,
  }) = _CraftsListUiModel;

  const CraftsListUiModel._();

  bool get isEmpty => rows.isEmpty;
}

@freezed
abstract class CraftStationOption with _$CraftStationOption {
  const factory CraftStationOption({
    required String value,
    required String label,
    @Default(false) bool active,
  }) = _CraftStationOption;
}

@freezed
abstract class CraftRowUiModel with _$CraftRowUiModel {
  const factory CraftRowUiModel({
    required String id,
    String? detailItemId,
    required String stationLabel,
    required int profit,
    required String durationLabel,
    String? profitPerHourLabel,
    @Default([]) List<CraftItemUiModel> requiredItems,
    @Default([]) List<CraftItemUiModel> rewardItems,
  }) = _CraftRowUiModel;
}

@freezed
abstract class CraftItemUiModel with _$CraftItemUiModel {
  const factory CraftItemUiModel({
    required String id,
    String? iconLink,
    required String shortName,
    required String countLabel,
  }) = _CraftItemUiModel;
}
