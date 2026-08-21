
import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:darkoff/domain/entities/craft_entity.dart';
import 'package:darkoff/presentation/features/crafts/model/crafts_list_ui_model.dart';

class CraftsListUiMapper {
  CraftsListUiModel build(
    List<CraftEntity> crafts, {
    String selectedStation = '',
    CraftSort sort = CraftSort.profitPerHour,
  }) {
    final filtered = _filterAndSort(
      crafts,
      selectedStation: selectedStation,
      sort: sort,
    );

    return CraftsListUiModel(
      stations: _stations(crafts, selectedStation),
      sortLabel: sort == CraftSort.profitPerHour
          ? tr.crafts.sort.profitPerHour
          : tr.crafts.sort.totalProfit,
      rows: filtered.map(_row).toList(),
    );
  }

  List<CraftEntity> _filterAndSort(
    List<CraftEntity> crafts, {
    required String selectedStation,
    required CraftSort sort,
  }) {
    final list = selectedStation.isEmpty
        ? [...crafts]
        : crafts
              .where((c) => c.stationNormalizedName == selectedStation)
              .toList();

    list.sort(
      (a, b) => sort == CraftSort.profitPerHour
          ? _profitPerHour(b).compareTo(_profitPerHour(a))
          : _profit(b).compareTo(_profit(a)),
    );

    return list;
  }

  List<CraftStationOption> _stations(
    List<CraftEntity> crafts,
    String selectedStation,
  ) {
    final seen = <String>{};
    final options = <CraftStationOption>[
      CraftStationOption(
        value: '',
        label: tr.common.filter.all,
        active: selectedStation.isEmpty,
      ),
    ];
    for (final c in crafts) {
      if (seen.add(c.stationNormalizedName)) {
        options.add(
          CraftStationOption(
            value: c.stationNormalizedName,
            label: c.stationName,
            active: selectedStation == c.stationNormalizedName,
          ),
        );
      }
    }
    return options;
  }

  CraftRowUiModel _row(CraftEntity craft) {
    final profit = _profit(craft);
    final isProfit = profit >= 0;
    final perHour = _profitPerHour(craft);

    return CraftRowUiModel(
      id: craft.id,
      detailItemId: craft.rewardItems.isNotEmpty
          ? craft.rewardItems.first.id
          : null,
      stationLabel: tr.crafts.card.stationLevel(
        station: craft.stationName,
        level: craft.level,
      ),
      profitLabel: '${profit >= 0 ? '+' : ''}${formatPrice(profit)} ₽',
      isProfit: isProfit,
      durationLabel: _formatDuration(craft.duration),
      profitPerHourLabel: isProfit
          ? tr.crafts.card.profitPerHour(value: formatPrice(perHour.round()))
          : null,
      requiredItems: craft.requiredItems.map(_item).toList(),
      rewardItems: craft.rewardItems.map(_item).toList(),
    );
  }

  CraftItemUiModel _item(ContainedItemEntity item) => CraftItemUiModel(
    id: item.id,
    iconLink: item.iconLink,
    shortName: item.shortName,
    countLabel: '${item.count.toInt()}×',
  );

  int _totalValue(List<ContainedItemEntity> items) =>
      items.fold(0, (sum, i) => sum + (i.price ?? 0) * i.count.round());

  int _profit(CraftEntity c) =>
      _totalValue(c.rewardItems) - _totalValue(c.requiredItems);

  double _profitPerHour(CraftEntity c) {
    if (c.duration <= 0) return 0;
    return _profit(c) / (c.duration / 3600);
  }

  String _formatDuration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0 && m > 0) return '${h}h ${m}m';
    if (h > 0) return '${h}h';
    return '${m}m';
  }
}
