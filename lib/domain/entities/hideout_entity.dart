import 'package:freezed_annotation/freezed_annotation.dart';

part 'hideout_entity.freezed.dart';

@freezed
abstract class HideoutBonusEntity with _$HideoutBonusEntity {
  const factory HideoutBonusEntity({
    required String type,
    required String name,
    double? value,
  }) = _HideoutBonusEntity;
}

@freezed
abstract class HideoutItemReqEntity with _$HideoutItemReqEntity {
  const factory HideoutItemReqEntity({
    required String id,
    required String name,
    required String shortName,
    String? iconLink,
    int? price,
    required int count,
  }) = _HideoutItemReqEntity;
}

@freezed
abstract class HideoutStationReqEntity with _$HideoutStationReqEntity {
  const factory HideoutStationReqEntity({
    required String stationId,
    required String stationName,
    required int level,
  }) = _HideoutStationReqEntity;
}

@freezed
abstract class HideoutTraderReqEntity with _$HideoutTraderReqEntity {
  const factory HideoutTraderReqEntity({
    required String traderId,
    required String traderName,
    int? loyaltyLevel,
  }) = _HideoutTraderReqEntity;
}

@freezed
abstract class HideoutLevelEntity with _$HideoutLevelEntity {
  const factory HideoutLevelEntity({
    required int level,
    required int constructionTime,
    @Default([]) List<HideoutItemReqEntity> itemRequirements,
    @Default([]) List<HideoutStationReqEntity> stationRequirements,
    @Default([]) List<HideoutTraderReqEntity> traderRequirements,
    @Default([]) List<HideoutBonusEntity> bonuses,
  }) = _HideoutLevelEntity;
}

@freezed
abstract class HideoutStationEntity with _$HideoutStationEntity {
  const factory HideoutStationEntity({
    required String id,
    required String name,
    required String normalizedName,
    String? imageLink,
    @Default([]) List<HideoutLevelEntity> levels,
  }) = _HideoutStationEntity;
}
