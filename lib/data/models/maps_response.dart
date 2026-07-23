import 'package:darkoff/data/models/map_api.dart';
import 'package:json_annotation/json_annotation.dart';

part 'maps_response.g.dart';

@JsonSerializable(createToJson: false)
class MapsResponse {
  const MapsResponse({this.data = const MapsData()});

  factory MapsResponse.fromJson(Map<String, dynamic> json) =>
      _$MapsResponseFromJson(json);

  final MapsData data;
}

@JsonSerializable(createToJson: false)
class MapsData {
  const MapsData({this.maps = const {}, this.mobs = const {}});

  factory MapsData.fromJson(Map<String, dynamic> json) =>
      _$MapsDataFromJson(json);

  final Map<String, MapApi> maps;
  final Map<String, MobApi> mobs;
}
