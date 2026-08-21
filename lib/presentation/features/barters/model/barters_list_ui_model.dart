import 'package:freezed_annotation/freezed_annotation.dart';

part 'barters_list_ui_model.freezed.dart';

enum BarterSort { profitDesc, profitAsc }

@freezed
abstract class BartersListUiModel with _$BartersListUiModel {
  const factory BartersListUiModel({
    @Default([]) List<BarterTraderOption> traders,
    @Default('') String sortLabel,
    @Default([]) List<BarterRowUiModel> rows,
  }) = _BartersListUiModel;

  const BartersListUiModel._();

  bool get isEmpty => rows.isEmpty;
}

@freezed
abstract class BarterTraderOption with _$BarterTraderOption {
  const factory BarterTraderOption({
    required String value,
    required String label,
    @Default(false) bool active,
  }) = _BarterTraderOption;
}

@freezed
abstract class BarterRowUiModel with _$BarterRowUiModel {
  const factory BarterRowUiModel({
    required String id,
    String? detailItemId,
    required String traderLabel,
    required String profitLabel,
    required bool isProfit,
    required String costLabel,
    required String valueLabel,
    @Default([]) List<BarterItemUiModel> requiredItems,
    @Default([]) List<BarterItemUiModel> rewardItems,
  }) = _BarterRowUiModel;
}

@freezed
abstract class BarterItemUiModel with _$BarterItemUiModel {
  const factory BarterItemUiModel({
    required String id,
    String? iconLink,
    required String shortName,
    required String countLabel,
  }) = _BarterItemUiModel;
}
