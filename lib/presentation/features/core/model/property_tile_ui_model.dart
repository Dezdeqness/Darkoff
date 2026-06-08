import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_tile_ui_model.freezed.dart';

@freezed
abstract class PropertyTileUiModel with _$PropertyTileUiModel {
  const factory PropertyTileUiModel({
    required String label,
    required String value,
    @Default(PropertyValueType.normal) PropertyValueType type,
  }) = _PropertyTileUiModel;
}

enum PropertyValueType {
  positive,
  negative,
  accent,
  normal,
}
