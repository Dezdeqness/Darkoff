import 'package:freezed_annotation/freezed_annotation.dart';

part 'flea_item_ui_model.freezed.dart';

@freezed
abstract class FleaItemUiModel with _$FleaItemUiModel {
  const factory FleaItemUiModel({
    required String id,
    required String displayName,
    required String displayPrice,
    required int avgPrice,
    required double changePercent,
    String? iconLink,
    String? categoryName,
  }) = _FleaItemUiModel;
}
