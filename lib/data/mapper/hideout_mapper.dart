import 'package:darkoff/data/service/qraphql/queries/hideout.graphql.dart';
import 'package:darkoff/domain/entities/hideout_entity.dart';

class HideoutMapper {
  HideoutStationEntity fromGraphql(
    Query$DarkoffHideout$hideoutStations station,
  ) =>
      HideoutStationEntity(
        id: station.id,
        name: station.name,
        normalizedName: station.normalizedName,
        imageLink: station.imageLink,
        levels: station.levels
            .whereType<Query$DarkoffHideout$hideoutStations$levels>()
            .map(_mapLevel)
            .toList(),
      );

  HideoutLevelEntity _mapLevel(
    Query$DarkoffHideout$hideoutStations$levels level,
  ) =>
      HideoutLevelEntity(
        level: level.level,
        constructionTime: level.constructionTime,
        itemRequirements: level.itemRequirements
            .whereType<
                Query$DarkoffHideout$hideoutStations$levels$itemRequirements>()
            .map(
              (r) => HideoutItemReqEntity(
                id: r.item.id,
                name: r.item.name ?? r.item.shortName ?? '',
                shortName: r.item.shortName ?? '',
                iconLink: r.item.iconLink,
                price: r.item.avg24hPrice,
                count: r.count,
              ),
            )
            .toList(),
        stationRequirements: level.stationLevelRequirements
            .whereType<
                Query$DarkoffHideout$hideoutStations$levels$stationLevelRequirements>()
            .map(
              (r) => HideoutStationReqEntity(
                stationId: r.station.id,
                stationName: r.station.name,
                level: r.level,
              ),
            )
            .toList(),
        traderRequirements: level.traderRequirements
            .whereType<
                Query$DarkoffHideout$hideoutStations$levels$traderRequirements>()
            .map(
              (r) => HideoutTraderReqEntity(
                traderId: r.trader.id,
                traderName: r.trader.name,
                loyaltyLevel: r.value,
              ),
            )
            .toList(),
        bonuses: (level.bonuses ?? [])
            .whereType<Query$DarkoffHideout$hideoutStations$levels$bonuses>()
            .map(
              (b) => HideoutBonusEntity(
                type: b.type,
                name: b.name,
                value: b.value,
              ),
            )
            .toList(),
      );
}
