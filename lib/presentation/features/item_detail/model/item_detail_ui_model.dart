import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_detail_ui_model.freezed.dart';

@freezed
abstract class ItemDetailUiModel with _$ItemDetailUiModel {
  const factory ItemDetailUiModel({
    required String id,
    required String displayName,
    String? shortName,
    String? description,
    required int basePrice,
    int? avg24hPrice,
    int? low24hPrice,
    int? high24hPrice,
    double? changeLast48hPercent,
    int? width,
    int? height,
    double? weight,
    required String backgroundColor,
    String? imageUrl,
    String? wikiLink,
    required String categoryLabel,
    @Default([]) List<PriceUiModel> sellFor,
    @Default([]) List<PriceUiModel> buyFor,
    ItemProperties? properties,
  }) = _ItemDetailUiModel;
}

@freezed
abstract class PriceUiModel with _$PriceUiModel {
  const factory PriceUiModel({
    required int price,
    required String currency,
    required String sourceName,
  }) = _PriceUiModel;
}
