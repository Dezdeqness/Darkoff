import 'package:darkoff/data/service/qraphql/queries/market_snapshot.graphql.dart';
import 'package:darkoff/domain/entities/market_item_entity.dart';

class MarketMapper {
  MarketItemEntity fromGraphql(Query$DarkoffMarketSnapshot$items item) =>
      MarketItemEntity(
        id: item.id,
        name: item.name ?? item.shortName ?? item.id,
        shortName: item.shortName ?? item.name ?? item.id,
        avg24hPrice: item.avg24hPrice,
        lastLowPrice: item.lastLowPrice,
        changeLast48hPercent: item.changeLast48hPercent,
      );

  List<MarketItemEntity> fromGraphqlList(
    List<Query$DarkoffMarketSnapshot$items?> items,
  ) {
    return items
        .whereType<Query$DarkoffMarketSnapshot$items>()
        .map(fromGraphql)
        .toList();
  }
}
