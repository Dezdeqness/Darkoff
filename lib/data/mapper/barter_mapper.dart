import 'package:darkoff/data/models/barter_api.dart';
import 'package:darkoff/data/models/item_api.dart' show ContainedRefApi;
import 'package:darkoff/data/models/trader_dump_api.dart';
import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:darkoff/domain/entities/item_mini_info.dart';

class BarterMapper {
  BarterEntity map(
    BarterApi barter, {
    required Map<String, TraderDumpApi> traders,
    required Map<String, String> traderLoc,
    required Map<String, ItemMiniInfo> items,
  }) {
    final trader = traders[barter.trader];
    final rewards = <ContainedItemEntity>[
      if (barter.offeredItem != null) _line(barter.offeredItem!, items),
      for (final r in barter.rewardItems) _line(r, items),
    ];

    return BarterEntity(
      id: barter.id,
      traderName:
          traderLoc[trader?.name] ?? trader?.name ?? barter.trader ?? '',
      traderNormalizedName: trader?.normalizedName ?? '',
      level: barter.level ?? barter.minTraderLevel ?? 0,
      requiredItems: [for (final r in barter.requiredItems) _line(r, items)],
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

  Set<String> collectItemIds(Iterable<BarterApi> barters) {
    final ids = <String>{};
    for (final b in barters) {
      for (final r in b.requiredItems) {
        ids.add(r.item);
      }
      if (b.offeredItem != null) ids.add(b.offeredItem!.item);
      for (final r in b.rewardItems) {
        ids.add(r.item);
      }
    }
    return ids;
  }
}
