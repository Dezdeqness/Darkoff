import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:darkoff/presentation/features/barters/model/barters_list_ui_model.dart';

class BartersListUiMapper {
  BartersListUiModel build(
    List<BarterEntity> barters, {
    String selectedTrader = '',
    BarterSort sort = BarterSort.profitDesc,
  }) {
    final filtered = _filterAndSort(
      barters,
      selectedTrader: selectedTrader,
      sort: sort,
    );

    return BartersListUiModel(
      traders: _traders(barters, selectedTrader),
      sortLabel: sort == BarterSort.profitDesc
          ? tr.barters.sort.profitDesc
          : tr.barters.sort.profitAsc,
      rows: filtered.map(_row).toList(),
    );
  }

  List<BarterEntity> _filterAndSort(
    List<BarterEntity> barters, {
    required String selectedTrader,
    required BarterSort sort,
  }) {
    final list = selectedTrader.isEmpty
        ? [...barters]
        : barters
              .where((b) => b.traderNormalizedName == selectedTrader)
              .toList();

    list.sort(
      (a, b) => sort == BarterSort.profitDesc
          ? _profit(b).compareTo(_profit(a))
          : _profit(a).compareTo(_profit(b)),
    );

    return list;
  }

  List<BarterTraderOption> _traders(
    List<BarterEntity> barters,
    String selectedTrader,
  ) {
    final seen = <String>{};
    final options = <BarterTraderOption>[
      BarterTraderOption(
        value: '',
        label: tr.common.filter.all,
        active: selectedTrader.isEmpty,
      ),
    ];
    for (final b in barters) {
      if (seen.add(b.traderNormalizedName)) {
        options.add(
          BarterTraderOption(
            value: b.traderNormalizedName,
            label: b.traderName,
            active: selectedTrader == b.traderNormalizedName,
          ),
        );
      }
    }
    return options;
  }

  BarterRowUiModel _row(BarterEntity barter) => BarterRowUiModel(
    id: barter.id,
    detailItemId: barter.rewardItems.isNotEmpty
        ? barter.rewardItems.first.id
        : null,
    traderLabel: '${barter.traderName} LL${barter.level}',
    profit: _profit(barter),
    costLabel: '${formatPrice(_totalValue(barter.requiredItems))} ₽',
    valueLabel: '${formatPrice(_totalValue(barter.rewardItems))} ₽',
    requiredItems: barter.requiredItems.map(_item).toList(),
    rewardItems: barter.rewardItems.map(_item).toList(),
  );

  BarterItemUiModel _item(ContainedItemEntity item) => BarterItemUiModel(
    id: item.id,
    iconLink: item.iconLink,
    shortName: item.shortName,
    countLabel: '${item.count.toInt()}×',
  );

  int _totalValue(List<ContainedItemEntity> items) =>
      items.fold(0, (sum, i) => sum + (i.price ?? 0) * i.count.round());

  int _profit(BarterEntity b) =>
      _totalValue(b.rewardItems) - _totalValue(b.requiredItems);
}
