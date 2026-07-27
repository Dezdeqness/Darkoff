import 'package:freezed_annotation/freezed_annotation.dart';

part 'key_entity.freezed.dart';

@freezed
abstract class KeyEntity with _$KeyEntity {
  const factory KeyEntity({
    required String id,
    required String name,
    required String shortName,
    String? iconLink,
    int? avgPrice,
    int? low24hPrice,
    int? high24hPrice,
    String? wikiLink,
    String? categoryName,
  }) = _KeyEntity;
}
