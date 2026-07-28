import 'package:darkoff/data/models/craft_api.dart';
import 'package:darkoff/data/models/hideout_api.dart';
import 'package:darkoff/data/models/item_api.dart' show ContainedRefApi;
import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:darkoff/domain/entities/craft_entity.dart';
import 'package:darkoff/domain/entities/item_mini_info.dart';

class CraftMapper {
  CraftEntity map(
    CraftApi craft, {
    required Map<String, HideoutStationApi> stations,
    required Map<String, String> stationLoc,
    required Map<String, ItemMiniInfo> items,
  }) {
    final station = stations[craft.station];
    final rewards = <ContainedItemEntity>[
      if (craft.productItem != null) _line(craft.productItem!, items),
      for (final r in craft.rewardItems) _line(r, items),
    ];

    return CraftEntity(
      id: craft.id,
      stationName:
          stationLoc[station?.name] ?? station?.name ?? craft.station ?? '',
      stationNormalizedName: station?.normalizedName ?? '',
      level: craft.level ?? 0,
      duration: craft.duration?.toInt() ?? 0,
      requiredItems: [for (final r in craft.requiredItems) _line(r, items)],
      rewardItems: rewards,
    );
  }

  ContainedItemEntity _line(
    ContainedRefApi r,
    Map<String, ItemMiniInfo> items,
  ) {
    final info = items[r.item];
    return ContainedItemEntity(
      id: r.item,
      name: info?.name ?? info?.shortName ?? '',
      shortName: info?.shortName ?? '',
      iconLink: info?.iconLink,
      price: info?.price,
      count: r.count?.toDouble() ?? 0,
    );
  }

  Set<String> collectItemIds(Iterable<CraftApi> crafts) {
    final ids = <String>{};
    for (final c in crafts) {
      for (final r in c.requiredItems) {
        ids.add(r.item);
      }
      if (c.productItem != null) ids.add(c.productItem!.item);
      for (final r in c.rewardItems) {
        ids.add(r.item);
      }
    }
    return ids;
  }
}
