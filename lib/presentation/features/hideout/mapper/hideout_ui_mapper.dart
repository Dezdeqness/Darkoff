import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/hideout_entity.dart';
import 'package:darkoff/domain/entities/hideout_progress_entity.dart';
import 'package:darkoff/presentation/features/hideout/model/hideout_list_ui_model.dart';
import 'package:darkoff/presentation/features/hideout/utils/hideout_progress_utils.dart';

class HideoutUiMapper {
  HideoutListUiModel toListModel(
    List<HideoutStationEntity> stations,
    HideoutProgressEntity progress,
  ) {
    final stats = {
      for (final s in stations) s.id: computeStationStats(s, progress),
    };
    final shopping = computeShoppingList(stations, progress);

    bool isDone(HideoutStationEntity s) =>
        s.levels.isNotEmpty && stats[s.id]!.builtLevels == s.levels.length;
    final ordered = [
      ...stations.where((s) => !isDone(s)),
      ...stations.where(isDone),
    ];

    return HideoutListUiModel(
      summary: _summary(shopping),
      shoppingEntry: _shoppingEntry(shopping),
      stations: [
        for (final station in ordered)
          _stationCard(station, stats[station.id]!),
      ],
    );
  }

  HideoutSummaryUiModel _summary(ShoppingList shopping) {
    final tracking = shopping.totalUnits > 0;

    return HideoutSummaryUiModel(
      title: tracking
          ? tr.hideout.summary.tracked(
              stations: shopping.stationCount,
              owned: shopping.ownedUnits,
              total: shopping.totalUnits,
            )
          : tr.hideout.upgrade.empty.title,
      subtitle: tracking
          ? tr.hideout.upgrade.help
          : tr.hideout.upgrade.guidance,
      displayCost: tracking ? '${formatPrice(shopping.totalCost)} ₽' : null,
    );
  }

  ShoppingEntryUiModel _shoppingEntry(ShoppingList shopping) {
    final empty = shopping.items.isEmpty;

    return ShoppingEntryUiModel(
      title: empty
          ? tr.hideout.shopping.empty.title
          : tr.hideout.shopping.itemsStillNeeded(count: shopping.totalCount),
      subtitle: empty
          ? tr.hideout.shopping.guidance.track
          : tr.hideout.shopping.guidance.tap,
      enabled: !empty,
    );
  }

  StationCardUiModel _stationCard(
    HideoutStationEntity station,
    StationProgressStats stats,
  ) {
    final fullyBuilt = station.levels.isNotEmpty &&
        stats.builtLevels == station.levels.length;

    return StationCardUiModel(
      id: station.id,
      name: station.name,
      imageLink: station.imageLink,
      totalLevels: station.levels.length,
      builtLevels: stats.builtLevels,
      metaText: fullyBuilt
          ? tr.hideout.status.fullyBuilt
          : tr.hideout.station.meta(
              collected: stats.collectedItems,
              total: stats.totalItems,
              cost: formatCompactPrice(stats.neededCost),
            ),
      progress: stats.itemsFraction,
      fullyBuilt: fullyBuilt,
    );
  }
}
