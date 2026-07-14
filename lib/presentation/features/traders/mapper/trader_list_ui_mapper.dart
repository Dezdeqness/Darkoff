import 'package:darkoff/domain/entities/trader_entity.dart';
import 'package:darkoff/presentation/features/traders/model/trader_list_ui_model.dart';

class TraderListUiMapper {
  List<TraderListItemUiModel> toListModel(List<TraderEntity> traders) => traders
      .where(
        (trader) => trader.barters.isNotEmpty,
      )
      .map(
        (trader) => TraderListItemUiModel(
          id: trader.id,
          name: trader.name,
          imageLink: trader.imageLink,
          resetTime: trader.resetTime,
          tradesText: _tradesText(trader),
        ),
      )
      .toList();

  String _tradesText(TraderEntity trader) {
    final parts = <String>[
      if (trader.cashOffers.isNotEmpty) '${trader.cashOffers.length} offers',
      if (trader.barters.isNotEmpty) '${trader.barters.length} barters',
    ];
    return parts.join(' · ');
  }
}
