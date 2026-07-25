import 'package:json_annotation/json_annotation.dart';

part 'map_api.g.dart';

@JsonSerializable(createToJson: false)
class MapApi {
  const MapApi({
    required this.id,
    this.name,
    this.normalizedName,
    this.description,
    this.players,
    this.raidDuration,
    this.enemies = const [],
    this.minPlayerLevel,
    this.maxPlayerLevel,
    this.bosses = const [],
  });

  factory MapApi.fromJson(Map<String, dynamic> json) => _$MapApiFromJson(json);

  final String id;
  final String? name;
  final String? normalizedName;
  final String? description;
  final String? players;
  final int? raidDuration;
  final List<String> enemies;
  final int? minPlayerLevel;
  final int? maxPlayerLevel;
  final List<BossSpawnApi> bosses;
}

@JsonSerializable(createToJson: false)
class BossSpawnApi {
  const BossSpawnApi({
    this.mob,
    this.spawnChance,
    this.spawnLocations = const [],
    this.escorts = const [],
  });

  factory BossSpawnApi.fromJson(Map<String, dynamic> json) =>
      _$BossSpawnApiFromJson(json);

  final String? mob;
  final num? spawnChance;
  final List<SpawnLocationApi> spawnLocations;
  final List<EscortApi> escorts;
}

@JsonSerializable(createToJson: false)
class SpawnLocationApi {
  const SpawnLocationApi({this.name, this.spawnKey});

  factory SpawnLocationApi.fromJson(Map<String, dynamic> json) =>
      _$SpawnLocationApiFromJson(json);

  final String? name;
  final String? spawnKey;
}

@JsonSerializable(createToJson: false)
class EscortApi {
  const EscortApi({this.mob, this.amount = const []});

  factory EscortApi.fromJson(Map<String, dynamic> json) =>
      _$EscortApiFromJson(json);

  final String? mob;
  final List<EscortAmountApi> amount;
}

@JsonSerializable(createToJson: false)
class EscortAmountApi {
  const EscortAmountApi({this.count, this.chance});

  factory EscortAmountApi.fromJson(Map<String, dynamic> json) =>
      _$EscortAmountApiFromJson(json);

  final int? count;
  final num? chance;
}

@JsonSerializable(createToJson: false)
class MobApi {
  const MobApi({
    this.id,
    this.name,
    this.normalizedName,
    this.imagePortraitLink,
    this.imagePosterLink,
    this.health = const [],
    this.items = const [],
    this.equipment = const [],
  });

  factory MobApi.fromJson(Map<String, dynamic> json) => _$MobApiFromJson(json);

  final String? id;
  final String? name;
  final String? normalizedName;
  final String? imagePortraitLink;
  final String? imagePosterLink;
  final List<MobHealthApi> health;
  final List<MobLootApi> items;
  final List<MobEquipmentApi> equipment;
}

@JsonSerializable(createToJson: false)
class MobEquipmentApi {
  const MobEquipmentApi({this.item, this.contains = const []});

  factory MobEquipmentApi.fromJson(Map<String, dynamic> json) =>
      _$MobEquipmentApiFromJson(json);

  final String? item;
  final List<MobEquipmentApi> contains;
}

@JsonSerializable(createToJson: false)
class MobLootApi {
  const MobLootApi({this.id, this.attributes});

  factory MobLootApi.fromJson(Map<String, dynamic> json) =>
      _$MobLootApiFromJson(json);

  final String? id;
  final MobLootAttributesApi? attributes;
}

@JsonSerializable(createToJson: false)
class MobLootAttributesApi {
  const MobLootAttributesApi({this.prevalence});

  factory MobLootAttributesApi.fromJson(Map<String, dynamic> json) =>
      _$MobLootAttributesApiFromJson(json);

  final num? prevalence;
}

@JsonSerializable(createToJson: false)
class MobHealthApi {
  const MobHealthApi({this.id, this.max, this.bodyPart});

  factory MobHealthApi.fromJson(Map<String, dynamic> json) =>
      _$MobHealthApiFromJson(json);

  final String? id;
  final int? max;
  final String? bodyPart;
}
