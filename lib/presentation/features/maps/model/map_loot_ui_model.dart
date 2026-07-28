import 'package:freezed_annotation/freezed_annotation.dart';

part 'map_loot_ui_model.freezed.dart';

@freezed
abstract class MapLootUiModel with _$MapLootUiModel {
  const factory MapLootUiModel({
    required String id,
    required String name,
    required String priceLabel,
    String? iconUrl,
  }) = _MapLootUiModel;
}
