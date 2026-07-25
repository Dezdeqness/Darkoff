import 'package:darkoff/data/models/map_api.dart';
import 'package:darkoff/domain/entities/boss_entity.dart';

class BossMapper {
  const BossMapper();

  List<BossEntity> bossesAll(
    List<MapApi> maps,
    Map<String, MobApi> mobs,
    Map<String, String> loc,
  ) {
    final acc = <String, _BossAcc>{};

    for (final m in maps) {
      final mapName = loc[m.name] ?? m.name ?? m.id;
      for (final spawn in m.bosses) {
        final mobId = spawn.mob;
        if (mobId == null) continue;
        final mob = mobs[mobId];
        if (!_isMainBoss(mob)) continue;

        acc.putIfAbsent(
          mobId,
          () => _BossAcc(
            id: mob?.id ?? mobId,
            name: loc[mob?.name] ?? mob?.name ?? mobId,
            normalizedName: mob?.normalizedName ?? '',
            portrait: mob?.imagePortraitLink,
            poster: mob?.imagePosterLink,
            totalHealth: _totalHealth(mob),
            bodyParts: _bodyParts(mob),
            loot: _loot(mob),
          ),
        );

        acc[mobId]!.mapSpawns.add(
          BossMapSpawnEntity(
            mapName: mapName,
            spawnChance: spawn.spawnChance?.toDouble() ?? 0,
            locationNames: [
              for (final l in spawn.spawnLocations) loc[l.name] ?? l.name ?? '',
            ],
            escorts: _escorts(spawn.escorts, mobs, loc),
          ),
        );
      }
    }

    return acc.values
        .map(
          (a) => BossEntity(
            id: a.id,
            name: a.name,
            normalizedName: a.normalizedName,
            imagePortraitLink: a.portrait,
            imagePosterLink: a.poster,
            healthMin: 0,
            healthMax: a.totalHealth,
            bodyParts: a.bodyParts,
            mapSpawns: a.mapSpawns,
            loot: a.loot,
          ),
        )
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  bool _isMainBoss(MobApi? mob) {
    final internal = mob?.name;
    if (internal == null) return false;
    return internal.startsWith('boss') || internal == 'sectantPriest';
  }

  List<BossBodyPartHealthEntity> _bodyParts(MobApi? mob) {
    if (mob == null) return const [];
    return [
      for (final h in mob.health)
        BossBodyPartHealthEntity(part: h.id ?? '', max: h.max ?? 0),
    ];
  }

  List<BossLootEntity> _loot(MobApi? mob) {
    if (mob == null) return const [];
    final byId = <String, double>{};
    for (final loot in mob.items) {
      final id = loot.id;
      if (id == null) continue;
      final prevalence = loot.attributes?.prevalence?.toDouble() ?? 0;
      byId[id] = prevalence > (byId[id] ?? 0) ? prevalence : byId[id] ?? 0;
    }
    return [
      for (final entry in byId.entries)
        BossLootEntity(itemId: entry.key, prevalence: entry.value),
    ];
  }

  int _totalHealth(MobApi? mob) {
    if (mob == null) return 0;
    var sum = 0;
    for (final h in mob.health) {
      sum += h.max ?? 0;
    }
    return sum;
  }

  List<BossEscortEntity> _escorts(
    List<EscortApi> escorts,
    Map<String, MobApi> mobs,
    Map<String, String> loc,
  ) {
    final out = <BossEscortEntity>[];
    for (final e in escorts) {
      final mob = mobs[e.mob];
      final name = loc[mob?.name] ?? mob?.name ?? e.mob ?? '';
      for (final a in e.amount) {
        out.add(
          BossEscortEntity(
            bossName: name,
            count: a.count ?? 0,
            chance: a.chance?.toDouble() ?? 0,
          ),
        );
      }
    }
    return out;
  }
}

class _BossAcc {
  _BossAcc({
    required this.id,
    required this.name,
    required this.normalizedName,
    this.portrait,
    this.poster,
    this.totalHealth,
    this.bodyParts = const [],
    this.loot = const [],
  });

  final String id;
  final String name;
  final String normalizedName;
  final String? portrait;
  final String? poster;
  final int? totalHealth;
  final List<BossBodyPartHealthEntity> bodyParts;
  final List<BossLootEntity> loot;
  final List<BossMapSpawnEntity> mapSpawns = [];
}
