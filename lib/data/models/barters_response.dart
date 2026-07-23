import 'package:darkoff/data/models/barter_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'barters_response.g.dart';

@JsonSerializable(createToJson: false)
class BartersResponse {
  const BartersResponse({this.data = const {}});

  factory BartersResponse.fromJson(Map<String, dynamic> json) =>
      _$BartersResponseFromJson(json);

  final Map<String, BarterApi> data;
}
