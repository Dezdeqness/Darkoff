import 'package:darkoff/data/service/qraphql/queries/items.graphql.dart';
import 'package:darkoff/data/utils/item_type_mapper.dart';
import 'package:darkoff/domain/entities/item_category_info.dart';
import 'package:darkoff/domain/entities/item_entity.dart';

class ItemMapper {
  ItemEntity fromGraphql(Query$DarkoffItems$items item) => ItemEntity(
        id: item.id,
        name: item.name,
        shortName: item.shortName,
        basePrice: item.basePrice,
        backgroundColor: item.backgroundColor,
        iconLink: item.iconLink,
        baseImageLink: item.baseImageLink,
        image512pxLink: item.image512pxLink,
        types: item.types
            .whereType()
            .map((t) => ItemTypeUtils.fromGraphqlEnum(t))
            .toList(),
        categories: item.categories
            .whereType<Query$DarkoffItems$items$categories>()
            .map(
              (c) => ItemCategoryInfo(
                id: c.id,
                name: c.name,
                normalizedName: c.normalizedName,
              ),
            )
            .toList(),
      );
}
