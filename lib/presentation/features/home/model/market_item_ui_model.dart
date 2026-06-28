import 'package:darkoff/presentation/features/home/model/price_change_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_item_ui_model.freezed.dart';

@freezed
abstract class MarketItemUiModel with _$MarketItemUiModel {
  const factory MarketItemUiModel({
    required String id,
    required String displayName,
    required String displayPrice,
    required String changeLabel,
    required PriceTrend trend,
  }) = _MarketItemUiModel;
}
