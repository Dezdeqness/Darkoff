import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:darkoff/domain/entities/trader_entity.dart';
import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';

class TraderDetailUiMapper {
  TraderDetailUiModel toModel(TraderEntity trader) => TraderDetailUiModel(
        id: trader.id,
        name: trader.name,
        imageLink: trader.imageLink,
        resetTime: trader.resetTime,
        offers: trader.cashOffers.map(_offer).toList(),
        barters: trader.barters.map(_barter).toList(),
      );

  TraderOfferUiModel _offer(TraderOfferEntity offer) {
    final price = offer.price ?? offer.priceRUB;
    final symbol = currencySymbol(
      offer.price != null ? (offer.currency ?? 'RUB') : 'RUB',
    );

    return TraderOfferUiModel(
      itemId: offer.item.id,
      itemName: offer.item.name,
      iconLink: offer.item.iconLink,
      priceText: price != null ? '${formatPrice(price)} $symbol' : null,
      minTraderLevel: offer.minTraderLevel,
    );
  }

  TraderBarterUiModel _barter(BarterEntity barter) => TraderBarterUiModel(
        level: barter.level,
        requiredItems: barter.requiredItems.map(_item).toList(),
        rewardItems: barter.rewardItems.map(_item).toList(),
      );

  TradeItemUiModel _item(ContainedItemEntity item) => TradeItemUiModel(
        itemId: item.id,
        shortName: item.shortName,
        iconLink: item.iconLink,
        count: item.count.toInt(),
      );
}
