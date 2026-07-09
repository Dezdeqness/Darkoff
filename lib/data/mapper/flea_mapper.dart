import 'package:darkoff/data/service/qraphql/queries/flea_market.graphql.dart';
import 'package:darkoff/domain/entities/flea_item_entity.dart';

class FleaMapper {
  FleaItemEntity fromGraphql(Query$DarkoffFleaMarket$items item) =>
      FleaItemEntity(
        id: item.id,
        name: item.name ?? item.shortName ?? '',
        shortName: item.shortName ?? item.name ?? '',
        iconLink: item.iconLink,
        avgPrice: item.avg24hPrice,
        low24hPrice: item.low24hPrice,
        high24hPrice: item.high24hPrice,
        changeLast48h: item.changeLast48h,
        changeLast48hPercent: item.changeLast48hPercent,
        categoryName: item.category?.name,
      );
}
