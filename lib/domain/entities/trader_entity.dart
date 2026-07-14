import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:darkoff/domain/entities/contained_item_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_entity.freezed.dart';

@freezed
abstract class TraderLevelEntity with _$TraderLevelEntity {
  const factory TraderLevelEntity({
    required int level,
    required int requiredPlayerLevel,
    required double requiredReputation,
    required int requiredCommerce,
  }) = _TraderLevelEntity;
}

/// A single item the trader sells for currency.
@freezed
abstract class TraderOfferEntity with _$TraderOfferEntity {
  const factory TraderOfferEntity({
    required ContainedItemEntity item,
    int? minTraderLevel,
    int? price,
    int? priceRUB,
    String? currency,
  }) = _TraderOfferEntity;
}

@freezed
abstract class TraderEntity with _$TraderEntity {
  const factory TraderEntity({
    required String id,
    required String name,
    required String normalizedName,
    String? imageLink,
    String? resetTime,
    String? description,
    String? currencyName,
    @Default([]) List<TraderLevelEntity> levels,
    @Default([]) List<TraderOfferEntity> cashOffers,
    @Default([]) List<BarterEntity> barters,
  }) = _TraderEntity;
}
