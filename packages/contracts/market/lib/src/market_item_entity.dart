import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_item_entity.freezed.dart';

@freezed
abstract class MarketItemEntity with _$MarketItemEntity {
  const factory MarketItemEntity({
    required String id,
    required String name,
    required String shortName,
    int? avg24hPrice,
    int? lastLowPrice,
    double? changeLast48hPercent,
  }) = _MarketItemEntity;
}
