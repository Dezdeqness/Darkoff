
import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:keys_contract/keys_contract.dart';
import 'package:darkoff/presentation/features/keys/model/keys_list_ui_model.dart';

class KeysListUiMapper {
  KeysListUiModel build(
    List<KeyEntity> keys, {
    String search = '',
    KeySort sort = KeySort.name,
  }) {
    final rows = _filterAndSort(keys, search: search, sort: sort);
    return KeysListUiModel(
      sortChips: _sortChips(sort),
      rows: rows.map(_row).toList(),
    );
  }

  List<KeyEntity> _filterAndSort(
    List<KeyEntity> keys, {
    required String search,
    required KeySort sort,
  }) {
    final query = search.toLowerCase();

    final list = keys.where((k) {
      if (query.isEmpty) return true;
      return k.name.toLowerCase().contains(query) ||
          k.shortName.toLowerCase().contains(query);
    }).toList();

    list.sort((a, b) {
      return switch (sort) {
        KeySort.name => a.name.compareTo(b.name),
        KeySort.priceAsc => (a.avgPrice ?? 0).compareTo(b.avgPrice ?? 0),
        KeySort.priceDesc => (b.avgPrice ?? 0).compareTo(a.avgPrice ?? 0),
      };
    });

    return list;
  }

  List<KeySortChipUiModel> _sortChips(KeySort sort) => [
    KeySortChipUiModel(
      value: KeySort.name,
      label: tr.keys.sort.name,
      active: sort == KeySort.name,
    ),
    KeySortChipUiModel(
      value: KeySort.priceDesc,
      label: tr.keys.sort.priceDesc,
      active: sort == KeySort.priceDesc,
    ),
    KeySortChipUiModel(
      value: KeySort.priceAsc,
      label: tr.keys.sort.priceAsc,
      active: sort == KeySort.priceAsc,
    ),
  ];

  KeyRowUiModel _row(KeyEntity key) {
    final hasPrice = key.avgPrice != null && key.avgPrice! > 0;
    final hasLow = key.low24hPrice != null && key.low24hPrice! > 0;

    return KeyRowUiModel(
      id: key.id,
      iconLink: key.iconLink,
      name: key.name,
      categoryLabel: key.categoryName,
      priceLabel: hasPrice ? '${formatPrice(key.avgPrice!)} ₽' : tr.common.value.noData,
      hasPrice: hasPrice,
      lowPriceLabel: hasLow
          ? tr.keys.row.lowPrice(price: formatPrice(key.low24hPrice!))
          : null,
    );
  }
}
