import 'package:darkoff/data/models/item_api.dart' show ContainedRefApi;
import 'package:json_annotation/json_annotation.dart';

part 'craft_api.g.dart';

@JsonSerializable(createToJson: false)
class CraftApi {
  const CraftApi({
    required this.id,
    this.station,
    this.level,
    this.duration,
    this.requiredItems = const [],
    this.productItem,
    this.rewardItems = const [],
  });

  factory CraftApi.fromJson(Map<String, dynamic> json) =>
      _$CraftApiFromJson(json);

  final String id;
  final String? station;
  final int? level;
  final num? duration;
  final List<ContainedRefApi> requiredItems;
  final ContainedRefApi? productItem;
  final List<ContainedRefApi> rewardItems;
}
