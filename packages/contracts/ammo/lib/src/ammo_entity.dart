import 'package:freezed_annotation/freezed_annotation.dart';

part 'ammo_entity.freezed.dart';

@freezed
abstract class AmmoEntity with _$AmmoEntity {
  const factory AmmoEntity({
    required String id,
    required String name,
    required String shortName,
    String? iconLink,
    int? price,
    String? caliber,
    required int damage,
    required int penetrationPower,
    required int armorDamage,
    required double fragmentationChance,
    required bool tracer,
    required String ammoType,
  }) = _AmmoEntity;
}
