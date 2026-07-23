import 'package:darkoff/data/models/trader_dump_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'traders_response.g.dart';

@JsonSerializable(createToJson: false)
class TradersResponse {
  const TradersResponse({this.data = const {}});

  factory TradersResponse.fromJson(Map<String, dynamic> json) =>
      _$TradersResponseFromJson(json);

  final Map<String, TraderDumpApi> data;
}
