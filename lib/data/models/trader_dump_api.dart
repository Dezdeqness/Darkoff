import 'package:json_annotation/json_annotation.dart';

part 'trader_dump_api.g.dart';

@JsonSerializable(createToJson: false)
class TraderDumpApi {
  const TraderDumpApi({
    required this.id,
    this.name,
    this.description,
    this.normalizedName,
    this.currency,
    this.resetTime,
    this.imageLink,
    this.levels = const [],
  });

  factory TraderDumpApi.fromJson(Map<String, dynamic> json) =>
      _$TraderDumpApiFromJson(json);

  final String id;
  final String? name;
  final String? description;
  final String? normalizedName;
  final String? currency;
  final String? resetTime;
  final String? imageLink;
  final List<TraderLevelDumpApi> levels;
}

@JsonSerializable(createToJson: false)
class TraderLevelDumpApi {
  const TraderLevelDumpApi({
    this.level,
    this.requiredPlayerLevel,
    this.requiredReputation,
    this.requiredCommerce,
  });

  factory TraderLevelDumpApi.fromJson(Map<String, dynamic> json) =>
      _$TraderLevelDumpApiFromJson(json);

  final int? level;
  final int? requiredPlayerLevel;
  final num? requiredReputation;
  final int? requiredCommerce;
}
