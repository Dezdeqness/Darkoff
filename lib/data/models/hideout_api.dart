import 'package:darkoff/data/models/item_api.dart' show ContainedRefApi;
import 'package:json_annotation/json_annotation.dart';

part 'hideout_api.g.dart';

@JsonSerializable(createToJson: false)
class HideoutStationApi {
  const HideoutStationApi({
    required this.id,
    this.name,
    this.normalizedName,
    this.imageLink,
    this.levels = const [],
  });

  factory HideoutStationApi.fromJson(Map<String, dynamic> json) =>
      _$HideoutStationApiFromJson(json);

  final String id;
  final String? name;
  final String? normalizedName;
  final String? imageLink;
  final List<HideoutLevelApi> levels;
}

@JsonSerializable(createToJson: false)
class HideoutLevelApi {
  const HideoutLevelApi({
    this.level,
    this.constructionTime,
    this.itemRequirements = const [],
    this.stationLevelRequirements = const [],
    this.traderRequirements = const [],
    this.bonuses = const [],
  });

  factory HideoutLevelApi.fromJson(Map<String, dynamic> json) =>
      _$HideoutLevelApiFromJson(json);

  final int? level;
  final int? constructionTime;
  final List<ContainedRefApi> itemRequirements;
  final List<HideoutStationReqApi> stationLevelRequirements;
  final List<HideoutTraderReqApi> traderRequirements;
  final List<HideoutBonusApi> bonuses;
}

@JsonSerializable(createToJson: false)
class HideoutStationReqApi {
  const HideoutStationReqApi({this.station, this.level});

  factory HideoutStationReqApi.fromJson(Map<String, dynamic> json) =>
      _$HideoutStationReqApiFromJson(json);

  final String? station;
  final int? level;
}

@JsonSerializable(createToJson: false)
class HideoutTraderReqApi {
  const HideoutTraderReqApi({this.trader, this.value});

  factory HideoutTraderReqApi.fromJson(Map<String, dynamic> json) =>
      _$HideoutTraderReqApiFromJson(json);

  final String? trader;
  final int? value;
}

@JsonSerializable(createToJson: false)
class HideoutBonusApi {
  const HideoutBonusApi({this.type, this.name, this.value});

  factory HideoutBonusApi.fromJson(Map<String, dynamic> json) =>
      _$HideoutBonusApiFromJson(json);

  final String? type;
  final String? name;
  final num? value;
}
