import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_change_ui_model.freezed.dart';

@freezed
abstract class PriceChangeUiModel with _$PriceChangeUiModel {
  const factory PriceChangeUiModel({
    required String id,
    required String name,
    required String changeLabel,
    required PriceTrend trend,
    String? iconUrl,
  }) = _PriceChangeUiModel;
}

enum PriceTrend { up, down, flat }
