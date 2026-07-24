import 'package:darkoff/data/models/barter_api.dart';
import 'package:darkoff/data/models/item_api.dart' show ContainedRefApi;
import 'package:darkoff/data/models/trader_dump_api.dart';
import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:darkoff/domain/entities/item_mini_info.dart';
import 'package:darkoff/domain/entities/trader_entity.dart';

class TraderMapper {
  TraderEntity map(
    TraderDumpApi trader, {
    required Map<String, String> traderLoc,
    required List<TraderOfferEntity> cashOffers,
    required List<BarterApi> barters,
    required Map<String, ItemMiniInfo> items,
  }) {
    final name = traderLoc[trader.name] ?? trader.name ?? trader.id;
    final normalizedName = trader.normalizedName ?? '';

    return TraderEntity(
      id: trader.id,
      name: name,
      normalizedName: normalizedName,
      imageLink: trader.imageLink,
      resetTime: trader.resetTime,
      description: traderLoc[trader.description],
      currencyName: trader.currency,
      levels: [
        for (final l in trader.levels)
          TraderLevelEntity(
            level: l.level ?? 0,
            requiredPlayerLevel: l.requiredPlayerLevel ?? 0,
            requiredReputation: l.requiredReputation?.toDouble() ?? 0,
            requiredCommerce: l.requiredCommerce ?? 0,
          ),
      ],
      cashOffers: cashOffers,
      barters: [
        for (final b in barters)
          BarterEntity(
            id: b.id,
            traderName: name,
            traderNormalizedName: normalizedName,
            level: b.level ?? b.minTraderLevel ?? 0,
            requiredItems: [for (final r in b.requiredItems) _line(r, items)],
            rewardItems: _rewards(b, items),
          ),
      ],
    );
  }

  List<ContainedItemEntity> _rewards(
    BarterApi barter,
    Map<String, ItemMiniInfo> items,
  ) => [
    if (barter.offeredItem != null) _line(barter.offeredItem!, items),
    for (final r in barter.rewardItems) _line(r, items),
  ];

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
