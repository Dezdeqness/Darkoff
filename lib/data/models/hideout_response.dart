import 'package:darkoff/data/models/hideout_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hideout_response.g.dart';

@JsonSerializable(createToJson: false)
class HideoutResponse {
  const HideoutResponse({this.data = const {}});

  factory HideoutResponse.fromJson(Map<String, dynamic> json) =>
      _$HideoutResponseFromJson(json);

  final Map<String, HideoutStationApi> data;
}
