import 'package:darkoff/core/localization/strings.g.dart';
import 'package:hideout_contract/hideout_contract.dart';
import 'package:hideout_progress_contract/hideout_progress_contract.dart';

const hideoutCurrencyItemIds = {
  '5449016a4bdc2d6f028b456f', // Roubles
  '5696686a4bdc2da3298b456a', // Dollars
  '569668774bdc2da2298b4568', // Euros
};

String hideoutCurrencySymbol(String itemId) => switch (itemId) {
      '5696686a4bdc2da3298b456a' => r'$',
      '569668774bdc2da2298b4568' => '€',
      _ => '₽',
    };

class StationProgressStats {
  const StationProgressStats({
    required this.collectedItems,
    required this.totalItems,
    required this.neededCost,
    required this.builtLevels,
  });

  final int collectedItems;
  final int totalItems;
  final int neededCost;
  final int builtLevels;

  double get itemsFraction =>
      totalItems == 0 ? 0 : collectedItems / totalItems;
}

StationProgressStats computeStationStats(
  HideoutStationEntity station,
  HideoutProgressEntity progress,
) {
  var collected = 0;
  var total = 0;
  var needed = 0;
  var built = 0;

  for (final level in station.levels) {
    final levelKey = HideoutProgressEntity.levelKey(station.id, level.level);
    if (progress.builtLevels.contains(levelKey)) {
      built++;
      continue;
    }

    for (final req in level.itemRequirements) {
      final owned = progress.ownedCounts[
              HideoutProgressEntity.itemKey(station.id, level.level, req.id)] ??
          0;
      final missing = (req.count - owned).clamp(0, req.count);

      if (hideoutCurrencyItemIds.contains(req.id)) {
        // 1 rouble costs 1 rouble; foreign currency falls back to avg price.
        needed += missing * (req.price ?? 1);
      } else {
        collected += owned.clamp(0, req.count);
        total += req.count;
        needed += missing * (req.price ?? 0);
      }
    }
  }

  return StationProgressStats(
    collectedItems: collected,
    totalItems: total,
    neededCost: needed,
    builtLevels: built,
  );
}

class ShoppingListItem {
  ShoppingListItem({
    required this.itemId,
    required this.name,
    required this.shortName,
    required this.iconLink,
    required this.price,
    required this.neededCount,
    required this.sources,
  });

  final String itemId;
  final String name;
  final String shortName;
  final String? iconLink;
  final int? price;
  int neededCount;
  final List<String> sources;

  int get totalCost => (price ?? 0) * neededCount;
}

class ShoppingList {
  const ShoppingList({
    required this.items,
    required this.stationCount,
    required this.ownedUnits,
    required this.totalUnits,
  });

  final List<ShoppingListItem> items;
  final int stationCount;

  final int ownedUnits;
  final int totalUnits;

  int get totalCount => items.fold(0, (s, i) => s + i.neededCount);
  int get totalCost => items.fold(0, (s, i) => s + i.totalCost);
}

ShoppingList computeShoppingList(
  List<HideoutStationEntity> stations,
  HideoutProgressEntity progress,
) {
  final byItem = <String, ShoppingListItem>{};
  final contributingStations = <String>{};
  var ownedUnits = 0;
  var totalUnits = 0;

  for (final station in stations) {
    if (!progress.trackedStations.contains(station.id)) continue;

    final nextUp = station.levels.where((l) => !progress.builtLevels
        .contains(HideoutProgressEntity.levelKey(station.id, l.level)));
    if (nextUp.isEmpty) continue;
    final level = nextUp.first;

    for (final req in level.itemRequirements) {
      if (hideoutCurrencyItemIds.contains(req.id)) continue;

      final owned = (progress.ownedCounts[HideoutProgressEntity.itemKey(
                  station.id, level.level, req.id)] ??
              0)
          .clamp(0, req.count);

      totalUnits += req.count;
      ownedUnits += owned;

      final missing = req.count - owned;
      if (missing <= 0) continue;

      contributingStations.add(station.id);
      final source = tr.hideout.station.sourceLevel(
        station: station.name,
        level: level.level,
      );

      final existing = byItem[req.id];
      if (existing == null) {
        byItem[req.id] = ShoppingListItem(
          itemId: req.id,
          name: req.name,
          shortName: req.shortName,
          iconLink: req.iconLink,
          price: req.price,
          neededCount: missing,
          sources: [source],
        );
      } else {
        existing.neededCount += missing;
        existing.sources.add(source);
      }
    }
  }

  final items = byItem.values.toList()
    ..sort((a, b) => b.totalCost.compareTo(a.totalCost));

  return ShoppingList(
    items: items,
    stationCount: contributingStations.length,
    ownedUnits: ownedUnits,
    totalUnits: totalUnits,
  );
}
