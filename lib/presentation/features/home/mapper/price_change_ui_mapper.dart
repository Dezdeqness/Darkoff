import 'package:darkoff/domain/entities/flea_item_entity.dart';
import 'package:darkoff/presentation/features/home/model/price_change_ui_model.dart';

const _minPrice = 50000;

class PriceChangeUiMapper {

  List<PriceChangeUiModel> fromEntityList(
    List<FleaItemEntity> items, {
    int limit = 6,
  }) {
    final movers = items
        .where((i) =>
            (i.avgPrice ?? 0) > _minPrice && i.changeLast48hPercent != null)
        .toList()
      ..sort((a, b) =>
          b.changeLast48hPercent!.compareTo(a.changeLast48hPercent!));

    return movers.take(limit).map(_fromEntity).toList();
  }

  PriceChangeUiModel _fromEntity(FleaItemEntity entity) {
    final percent = entity.changeLast48hPercent ?? 0;
    return PriceChangeUiModel(
      id: entity.id,
      name: entity.name,
      iconUrl: entity.iconLink,
      changeLabel: _changeLabel(percent),
      trend: _trend(percent),
    );
  }

  String _changeLabel(double percent) {
    final sign = percent >= 0 ? '+' : '';
    return '$sign${percent.toStringAsFixed(1)}%';
  }

  PriceTrend _trend(double percent) {
    if (percent == 0) return PriceTrend.flat;
    return percent > 0 ? PriceTrend.up : PriceTrend.down;
  }
}
