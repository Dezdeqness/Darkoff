import 'package:darkoff/data/service/qraphql/queries/ammo.graphql.dart';
import 'package:darkoff/domain/entities/ammo_entity.dart';

class AmmoMapper {
  AmmoEntity fromGraphql(Query$DarkoffAmmo$ammo ammo) => AmmoEntity(
        id: ammo.item.id,
        name: ammo.item.name ?? ammo.item.shortName ?? '',
        shortName: ammo.item.shortName ?? '',
        iconLink: ammo.item.iconLink,
        price: ammo.item.avg24hPrice,
        caliber: ammo.caliber,
        damage: ammo.damage,
        penetrationPower: ammo.penetrationPower,
        armorDamage: ammo.armorDamage,
        fragmentationChance: ammo.fragmentationChance,
        tracer: ammo.tracer,
        ammoType: ammo.ammoType,
      );
}
