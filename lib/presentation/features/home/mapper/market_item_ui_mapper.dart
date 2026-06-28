import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/market_item_entity.dart';
import 'package:darkoff/presentation/features/home/model/market_item_ui_model.dart';
import 'package:darkoff/presentation/features/home/model/price_change_ui_model.dart';

class MarketItemUiMapper {
  MarketItemUiModel fromEntity(MarketItemEntity entity) {
    final price = entity.avg24hPrice ?? entity.lastLowPrice ?? 0;
    return MarketItemUiModel(
      id: entity.id,
      displayName: entity.shortName,
      displayPrice: formatCompactPrice(price),
      changeLabel: _changeLabel(entity.changeLast48hPercent),
      trend: _trend(entity.changeLast48hPercent),
    );
  }

  List<MarketItemUiModel> fromEntities(List<MarketItemEntity> entities) {
    return entities.map(fromEntity).toList();
  }

  String _changeLabel(double? pct) {
    if (pct == null) return '—';
    final sign = pct >= 0 ? '+' : '';
    return '$sign${pct.toStringAsFixed(1)}%';
  }

  PriceTrend _trend(double? pct) {
    if (pct == null || pct == 0) return PriceTrend.flat;
    return pct > 0 ? PriceTrend.up : PriceTrend.down;
  }
}
