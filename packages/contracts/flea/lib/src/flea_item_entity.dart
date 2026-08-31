import 'package:freezed_annotation/freezed_annotation.dart';

part 'flea_item_entity.freezed.dart';

@freezed
abstract class FleaItemEntity with _$FleaItemEntity {
  const factory FleaItemEntity({
    required String id,
    required String name,
    required String shortName,
    String? iconLink,
    int? avgPrice,
    int? low24hPrice,
    int? high24hPrice,
    double? changeLast48h,
    double? changeLast48hPercent,
    String? categoryName,
  }) = _FleaItemEntity;
}
