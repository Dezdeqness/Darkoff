import 'package:darkoff/data/models/map_api.dart';
import 'package:maps_contract/maps_contract.dart';

class MapMapper {
  const MapMapper();

  List<MapEntity> mapAll(
    List<MapApi> maps,
    Map<String, MobApi> mobs,
    Map<String, String> loc,
  ) => [for (final m in maps) _map(m, mobs, loc)];

  MapEntity _map(MapApi m, Map<String, MobApi> mobs, Map<String, String> loc) {
    final bosses = <String, BossSpawnEntity>{};
    final lootIds = <String>{};

    for (final b in m.bosses) {
      final mobId = b.mob;
      if (mobId == null) continue;
      final mob = mobs[mobId];
      if (!_isMainBoss(mob)) continue;

      final chance = b.spawnChance?.toDouble();
      final existing = bosses[mobId];
      if (existing == null || (chance ?? 0) > (existing.spawnChance ?? 0)) {
        bosses[mobId] = BossSpawnEntity(
          id: mob?.id ?? mobId,
          bossName: loc[mob?.name] ?? mob?.name ?? mobId,
          spawnChance: chance,
          imagePortraitLink: mob?.imagePortraitLink,
        );
      }

      lootIds.addAll(_loot(mob));
    }

    return MapEntity(
      id: m.id,
      name: loc[m.name] ?? m.name ?? m.id,
      normalizedName: m.normalizedName ?? '',
      description: loc[m.description] ?? m.description,
      players: m.players,
      raidDuration: m.raidDuration,
      enemies: [for (final e in m.enemies) loc[e] ?? e],
      minPlayerLevel: m.minPlayerLevel,
      maxPlayerLevel: m.maxPlayerLevel,
      bosses: bosses.values.toList(),
      lootItemIds: lootIds.toList(),
    );
  }

  bool _isMainBoss(MobApi? mob) {
    final internal = mob?.name;
    if (internal == null) return false;
    return internal.startsWith('boss') || internal == 'sectantPriest';
  }

  Set<String> _loot(MobApi? mob) {
    if (mob == null) return const {};
    final ids = <String>{};

    void walk(List<MobEquipmentApi> nodes) {
      for (final n in nodes) {
        if (n.item != null) ids.add(n.item!);
        walk(n.contains);
      }
    }

    walk(mob.equipment);

    for (final loot in mob.items) {
      final id = loot.id;
      if (id == null) continue;
      if ((loot.attributes?.prevalence?.toDouble() ?? 0) < 1.0) continue;
      ids.add(id);
    }

    return ids;
  }
}
