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
          offersCount: trader.cashOffers.length,
          bartersCount: trader.barters.length,
        ),
      )
      .toList();
}
