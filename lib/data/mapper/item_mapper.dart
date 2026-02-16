import 'package:darkoff/data/service/qraphql/queries/items.graphql.dart';
import 'package:darkoff/domain/entities/item_entity.dart';

class ItemMapper {

  ItemEntity fromGraphql(Query$DarkoffItems$items item) =>
      ItemEntity(
          id: item.id,
          name: item.name,
          shortName: item.shortName,
          basePrice: item.basePrice,
          backgroundColor: item.backgroundColor,
          iconLink: item.iconLink,
          baseImageLink: item.baseImageLink,
          image512pxLink: item.image512pxLink,
      );
}
