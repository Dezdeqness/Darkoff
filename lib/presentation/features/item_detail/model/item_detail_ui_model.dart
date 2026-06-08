import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/presentation/features/core/model/property_tile_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_detail_ui_model.freezed.dart';

@freezed
abstract class ItemDetailUiModel with _$ItemDetailUiModel {
  const factory ItemDetailUiModel({
    required String id,
    required String displayName,
    String? shortName,
    String? description,
    @Default([]) List<String> labels,
    @Default([]) List<PriceRowUiModel> prices,
    @Default([]) List<PropertyTileUiModel> properties,
    @Default([]) List<SellPriceUiModel> sellPrices,
    required String backgroundColor,
    String? imageUrl,
    String? wikiLink,
    required String categoryLabel,
    ItemProperties? itemProperties,
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

@freezed
abstract class SellPriceUiModel with _$SellPriceUiModel {
  const factory SellPriceUiModel({
    required String vendor,
    required String price,
  }) = _SellPriceUiModel;
}

@freezed
abstract class PriceRowUiModel with _$PriceRowUiModel {
  const factory PriceRowUiModel({
    required String label,
    required String price,
    String? badge,
    @Default(false) bool positiveBadge,
    @Default(false) bool highlight,
  }) = _PriceRowUiModel;
}