import 'package:freezed_annotation/freezed_annotation.dart';

part 'boss_loot_item_entity.freezed.dart';

@freezed
abstract class BossLootItemEntity with _$BossLootItemEntity {
  const factory BossLootItemEntity({
    required String id,
    required String name,
    String? iconLink,
    int? fleaPrice,
    int? traderPrice,
  }) = _BossLootItemEntity;
}
