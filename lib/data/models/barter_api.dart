import 'package:darkoff/data/models/item_api.dart' show ContainedRefApi;
import 'package:json_annotation/json_annotation.dart';

part 'barter_api.g.dart';

@JsonSerializable(createToJson: false)
class BarterApi {
  const BarterApi({
    required this.id,
    this.trader,
    this.level,
    this.minTraderLevel,
    this.requiredItems = const [],
    this.offeredItem,
    this.rewardItems = const [],
  });

  factory BarterApi.fromJson(Map<String, dynamic> json) =>
      _$BarterApiFromJson(json);

  final String id;
  final String? trader;
  final int? level;
  final int? minTraderLevel;
  final List<ContainedRefApi> requiredItems;
  final ContainedRefApi? offeredItem;
  final List<ContainedRefApi> rewardItems;
}
