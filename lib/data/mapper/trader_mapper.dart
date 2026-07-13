import 'package:darkoff/data/service/qraphql/queries/traders.graphql.dart';
import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:darkoff/domain/entities/trader_entity.dart';

class TraderMapper {
  TraderEntity fromGraphql(Query$DarkoffTraders$traders trader) => TraderEntity(
        id: trader.id,
        name: trader.name,
        normalizedName: trader.normalizedName,
        imageLink: trader.imageLink,
        resetTime: trader.resetTime,
        description: trader.description,
        currencyName: trader.currency.name,
        levels: trader.levels
            .map(
              (level) => TraderLevelEntity(
                level: level.level,
                requiredPlayerLevel: level.requiredPlayerLevel,
                requiredReputation: level.requiredReputation,
                requiredCommerce: level.requiredCommerce,
              ),
            )
            .toList(),
        cashOffers: trader.cashOffers
            .whereType<Query$DarkoffTraders$traders$cashOffers>()
            .map(
              (offer) => TraderOfferEntity(
                item: _containedItem(
                  id: offer.item.id,
                  name: offer.item.name,
                  shortName: offer.item.shortName,
                  iconLink: offer.item.iconLink,
                  price: offer.item.avg24hPrice,
                  count: 1,
                ),
                minTraderLevel: offer.minTraderLevel,
                priceRUB: offer.priceRUB,
                currency: offer.currency,
              ),
            )
            .toList(),
        barters: trader.barters
            .whereType<Query$DarkoffTraders$traders$barters>()
            .map(
              (barter) => BarterEntity(
                id: barter.id,
                traderName: trader.name,
                traderNormalizedName: trader.normalizedName,
                level: barter.level,
                requiredItems: barter.requiredItems
                    .whereType<
                        Query$DarkoffTraders$traders$barters$requiredItems>()
                    .map(
                      (item) => _containedItem(
                        id: item.item.id,
                        name: item.item.name,
                        shortName: item.item.shortName,
                        iconLink: item.item.iconLink,
                        price: item.item.avg24hPrice,
                        count: item.count,
                      ),
                    )
                    .toList(),
                rewardItems: barter.rewardItems
                    .whereType<
                        Query$DarkoffTraders$traders$barters$rewardItems>()
                    .map(
                      (item) => _containedItem(
                        id: item.item.id,
                        name: item.item.name,
                        shortName: item.item.shortName,
                        iconLink: item.item.iconLink,
                        price: item.item.avg24hPrice,
                        count: item.count,
                      ),
                    )
                    .toList(),
              ),
            )
            .toList(),
      );

  ContainedItemEntity _containedItem({
    required String id,
    String? name,
    String? shortName,
    String? iconLink,
    int? price,
    required double count,
  }) =>
      ContainedItemEntity(
        id: id,
        name: name ?? shortName ?? '',
        shortName: shortName ?? '',
        iconLink: iconLink,
        price: price,
        count: count,
      );
}
