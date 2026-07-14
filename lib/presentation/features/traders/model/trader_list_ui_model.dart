import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_list_ui_model.freezed.dart';

@freezed
abstract class TraderListItemUiModel with _$TraderListItemUiModel {
  const factory TraderListItemUiModel({
    required String id,
    required String name,
    String? imageLink,
    String? resetTime,
    required String tradesText,
  }) = _TraderListItemUiModel;
}
