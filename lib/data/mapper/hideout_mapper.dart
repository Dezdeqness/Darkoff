import 'package:darkoff/data/models/hideout_api.dart';
import 'package:darkoff/data/models/item_api.dart' show ContainedRefApi;
import 'package:darkoff/data/models/trader_dump_api.dart';
import 'package:hideout_contract/hideout_contract.dart';
import 'package:darkoff/domain/entities/item_mini_info.dart';

class HideoutMapper {
  HideoutStationEntity map(
    HideoutStationApi station, {
    required Map<String, HideoutStationApi> stations,
    required Map<String, String> stationLoc,
    required Map<String, TraderDumpApi> traders,
    required Map<String, String> traderLoc,
    required Map<String, ItemMiniInfo> items,
  }) {
    return HideoutStationEntity(
      id: station.id,
      name: stationLoc[station.name] ?? station.name ?? station.id,
      normalizedName: station.normalizedName ?? '',
      imageLink: station.imageLink,
      levels: [
        for (final l in station.levels)
          _level(
            l,
            stations: stations,
            stationLoc: stationLoc,
            traders: traders,
            traderLoc: traderLoc,
            items: items,
          ),
      ],
    );
  }

  HideoutLevelEntity _level(
    HideoutLevelApi l, {
    required Map<String, HideoutStationApi> stations,
    required Map<String, String> stationLoc,
    required Map<String, TraderDumpApi> traders,
    required Map<String, String> traderLoc,
    required Map<String, ItemMiniInfo> items,
  }) {
    return HideoutLevelEntity(
      level: l.level ?? 0,
      constructionTime: l.constructionTime ?? 0,
      itemRequirements: [
        for (final r in l.itemRequirements) _itemReq(r, items),
      ],
      stationRequirements: [
        for (final r in l.stationLevelRequirements)
          _stationReq(r, stations, stationLoc),
      ],
      traderRequirements: [
        for (final r in l.traderRequirements) _traderReq(r, traders, traderLoc),
      ],
      bonuses: [for (final b in l.bonuses) _bonus(b, stationLoc)],
    );
  }

  HideoutItemReqEntity _itemReq(
    ContainedRefApi r,
    Map<String, ItemMiniInfo> items,
  ) {
    final info = items[r.item];
    return HideoutItemReqEntity(
      id: r.item,
      name: info?.name ?? info?.shortName ?? '',
      shortName: info?.shortName ?? '',
      iconLink: info?.iconLink,
      price: info?.price,
      count: r.count?.toInt() ?? 0,
    );
  }

  HideoutStationReqEntity _stationReq(
    HideoutStationReqApi r,
    Map<String, HideoutStationApi> stations,
    Map<String, String> stationLoc,
  ) {
    final s = stations[r.station];
    return HideoutStationReqEntity(
      stationId: r.station ?? '',
      stationName: stationLoc[s?.name] ?? s?.name ?? r.station ?? '',
      level: r.level ?? 0,
    );
  }

  HideoutTraderReqEntity _traderReq(
    HideoutTraderReqApi r,
    Map<String, TraderDumpApi> traders,
    Map<String, String> traderLoc,
  ) {
    final t = traders[r.trader];
    return HideoutTraderReqEntity(
      traderId: r.trader ?? '',
      traderName: traderLoc[t?.name] ?? t?.name ?? r.trader ?? '',
      loyaltyLevel: r.value,
    );
  }

  HideoutBonusEntity _bonus(HideoutBonusApi b, Map<String, String> stationLoc) {
    return HideoutBonusEntity(
      type: b.type ?? '',
      name: stationLoc[b.name] ?? b.name ?? '',
      value: b.value?.toDouble(),
    );
  }

  Set<String> collectItemIds(Iterable<HideoutStationApi> stations) {
    final ids = <String>{};
    for (final s in stations) {
      for (final l in s.levels) {
        for (final r in l.itemRequirements) {
          ids.add(r.item);
        }
      }
    }
    return ids;
  }
}
