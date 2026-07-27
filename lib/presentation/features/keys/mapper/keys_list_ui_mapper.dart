import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/key_entity.dart';
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
      label: 'A–Z',
      active: sort == KeySort.name,
    ),
    KeySortChipUiModel(
      value: KeySort.priceDesc,
      label: '↓ Price',
      active: sort == KeySort.priceDesc,
    ),
    KeySortChipUiModel(
      value: KeySort.priceAsc,
      label: '↑ Price',
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
      priceLabel: hasPrice ? '${formatPrice(key.avgPrice!)} ₽' : 'No data',
      hasPrice: hasPrice,
      lowPriceLabel: hasLow ? 'low ${formatPrice(key.low24hPrice!)} ₽' : null,
    );
  }
}
