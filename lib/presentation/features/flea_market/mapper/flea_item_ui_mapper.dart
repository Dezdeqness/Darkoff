import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/flea_item_entity.dart';
import 'package:darkoff/presentation/features/flea_market/model/flea_item_ui_model.dart';

class FleaItemUiMapper {
  FleaItemUiModel fromEntity(FleaItemEntity entity) {
    return FleaItemUiModel(
      id: entity.id,
      displayName: entity.shortName,
      displayPrice: '${formatPrice(entity.avgPrice ?? 0)} ₽',
      avgPrice: entity.avgPrice ?? 0,
      iconLink: entity.iconLink,
      changePercent: entity.changeLast48hPercent ?? 0,
      categoryName: entity.categoryName,
    );
  }

  List<FleaItemUiModel> fromEntities(List<FleaItemEntity> entities) {
    return entities.map(fromEntity).toList();
  }

}
