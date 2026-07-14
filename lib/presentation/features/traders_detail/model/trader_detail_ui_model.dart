import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_detail_ui_model.freezed.dart';

@freezed
abstract class TraderDetailUiModel with _$TraderDetailUiModel {
  const factory TraderDetailUiModel({
    required String id,
    required String name,
    String? imageLink,
    String? resetTime,
    @Default([]) List<TraderOfferUiModel> offers,
    @Default([]) List<TraderBarterUiModel> barters,
  }) = _TraderDetailUiModel;
}

@freezed
abstract class TraderOfferUiModel with _$TraderOfferUiModel {
  const factory TraderOfferUiModel({
    required String itemId,
    required String itemName,
    String? iconLink,
    String? priceText,
    int? minTraderLevel,
  }) = _TraderOfferUiModel;
}

@freezed
abstract class TraderBarterUiModel with _$TraderBarterUiModel {
  const factory TraderBarterUiModel({
    required int level,
    @Default([]) List<TradeItemUiModel> requiredItems,
    @Default([]) List<TradeItemUiModel> rewardItems,
  }) = _TraderBarterUiModel;
}

@freezed
abstract class TradeItemUiModel with _$TradeItemUiModel {
  const factory TradeItemUiModel({
    required String itemId,
    required String shortName,
    String? iconLink,
    required int count,
  }) = _TradeItemUiModel;
}
