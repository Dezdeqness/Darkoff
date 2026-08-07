import 'package:darkoff/core/localization/strings.g.dart';
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
      if (trader.cashOffers.isNotEmpty)
        tr.traders.card.offers(count: trader.cashOffers.length),
      if (trader.barters.isNotEmpty)
        tr.traders.card.barters(count: trader.barters.length),
    ];
    return parts.join(' · ');
  }
}
