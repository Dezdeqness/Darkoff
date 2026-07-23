import 'package:darkoff/data/models/craft_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crafts_response.g.dart';

@JsonSerializable(createToJson: false)
class CraftsResponse {
  const CraftsResponse({this.data = const {}});

  factory CraftsResponse.fromJson(Map<String, dynamic> json) =>
      _$CraftsResponseFromJson(json);

  final Map<String, CraftApi> data;
}
