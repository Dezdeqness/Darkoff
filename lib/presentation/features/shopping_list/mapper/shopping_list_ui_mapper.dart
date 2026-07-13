import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/hideout_entity.dart';
import 'package:darkoff/domain/entities/hideout_progress_entity.dart';
import 'package:darkoff/presentation/features/hideout/utils/hideout_progress_utils.dart';
import 'package:darkoff/presentation/features/shopping_list/model/shopping_list_ui_model.dart';

class ShoppingListUiMapper {
  ShoppingListUiModel toModel(
    List<HideoutStationEntity> stations,
    HideoutProgressEntity progress,
  ) {
    final shopping = computeShoppingList(stations, progress);

    return ShoppingListUiModel(
      title: '${shopping.totalCount} items · across '
          '${shopping.stationCount} stations',
      displayCost: '${formatPrice(shopping.totalCost)} ₽',
      rows: [
        for (final item in shopping.items)
          ShoppingListRowUiModel(
            itemId: item.itemId,
            shortName: item.shortName,
            iconLink: item.iconLink,
            sourcesText: item.sources.join(' · '),
            countText: '× ${item.neededCount}',
            displayCost:
                item.totalCost > 0 ? '${formatPrice(item.totalCost)} ₽' : null,
          ),
      ],
    );
  }
}
