import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_ui_model.freezed.dart';

@freezed
abstract class ItemUiModel with _$ItemUiModel {
  const factory ItemUiModel({
    required String id,
    required String displayName,
    required String? shortName,
    required int basePrice,
    required String backgroundColor,
    required String? iconUrl,
    required String? imageUrl,
    required String? highResImageUrl,
    @Default('') String categoryLabel,
  }) = _ItemUiModel;
}
