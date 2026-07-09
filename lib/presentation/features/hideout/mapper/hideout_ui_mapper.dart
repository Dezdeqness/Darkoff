import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/hideout_entity.dart';
import 'package:darkoff/domain/entities/hideout_progress_entity.dart';
import 'package:darkoff/presentation/features/hideout/model/hideout_list_ui_model.dart';
// import 'package:darkoff/presentation/features/hideout/utils/hideout_progress_utils.dart';

class HideoutUiMapper {
  HideoutListUiModel toListModel(
    List<HideoutStationEntity> stations,
    HideoutProgressEntity progress,
  ) {
    // final stats = {
    //   for (final s in stations) s.id: computeStationStats(s, progress),
    // };
    // final shopping = computeShoppingList(stations, progress);

    // bool isDone(HideoutStationEntity s) =>
    //     s.levels.isNotEmpty && stats[s.id]!.builtLevels == s.levels.length;
    // final ordered = [
    //   ...stations.where((s) => !isDone(s)),
    //   ...stations.where(isDone),
    // ];
   final ordered = [
     ...stations
   ];

    return HideoutListUiModel(
      // summary: _summary(shopping),
      summary: HideoutSummaryUiModel(title: '', subtitle: ''),
      // shoppingEntry: _shoppingEntry(shopping),
      shoppingEntry: ShoppingEntryUiModel(title: '', subtitle: '', enabled: false),
      stations: [
        for (final station in ordered)
          // _stationCard(station, stats[station.id]!),
          _stationCard(station),
      ],
    );
  }

  // HideoutSummaryUiModel _summary(ShoppingList shopping) {
  //   final tracking = shopping.totalUnits > 0;
  //
  //   return HideoutSummaryUiModel(
  //     title: tracking
  //         ? '${shopping.stationCount} tracked · ${shopping.ownedUnits} / '
  //             '${shopping.totalUnits} items owned'
  //         : 'No stations tracked',
  //     subtitle: tracking
  //         ? 'Needed for the next upgrade'
  //         : 'Star a station to plan its next upgrade',
  //     displayCost: tracking ? '${formatPrice(shopping.totalCost)} ₽' : null,
  //   );
  // }

  // ShoppingEntryUiModel _shoppingEntry(ShoppingList shopping) {
  //   final empty = shopping.items.isEmpty;
  //
  //   return ShoppingEntryUiModel(
  //     title: empty
  //         ? 'Nothing tracked yet'
  //         : '${shopping.totalCount} items still needed',
  //     subtitle: empty
  //         ? 'Track a station to build your list'
  //         : 'Tap for aggregated list',
  //     enabled: !empty,
  //   );
  // }

  StationCardUiModel _stationCard(
    HideoutStationEntity station,
    // StationProgressStats stats,
  ) {
    // final fullyBuilt = station.levels.isNotEmpty &&
    //     stats.builtLevels == station.levels.length;

    // return StationCardUiModel(
    //   id: station.id,
    //   name: station.name,
    //   imageLink: station.imageLink,
    //   totalLevels: station.levels.length,
    //   builtLevels: stats.builtLevels,
    //   metaText: fullyBuilt
    //       ? 'Fully built'
    //       : '${stats.collectedItems} / ${stats.totalItems} items collected · '
    //           '${formatCompactPrice(stats.neededCost)} ₽ needed',
    //   progress: stats.itemsFraction,
    //   fullyBuilt: fullyBuilt,
    // );
    return StationCardUiModel(
      id: station.id,
      name: station.name,
      imageLink: station.imageLink,
      totalLevels: station.levels.length,
      builtLevels: 4,
      metaText: 'Fully built',
      progress: 1.0,
      fullyBuilt: true,
    );
  }
}
