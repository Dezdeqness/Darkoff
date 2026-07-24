import 'package:json_annotation/json_annotation.dart';

part 'price_history_response.g.dart';

@JsonSerializable(createToJson: false)
class PriceHistoryResponse {
  const PriceHistoryResponse({this.data = const []});

  final List<PricePointApi> data;

  factory PriceHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$PriceHistoryResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class PricePointApi {
  const PricePointApi({
    this.priceMin,
    this.price,
    this.timestamp,
    this.offerCount,
    this.offerCountMin,
  });

  final num? priceMin;
  final num? price;
  final num? timestamp;
  final num? offerCount;
  final num? offerCountMin;

  factory PricePointApi.fromJson(Map<String, dynamic> json) =>
      _$PricePointApiFromJson(json);
}
