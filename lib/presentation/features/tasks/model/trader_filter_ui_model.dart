import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_filter_ui_model.freezed.dart';

@freezed
abstract class TraderFilterUiModel with _$TraderFilterUiModel {
  const factory TraderFilterUiModel({
    required String label,
    @Default('') String normalizedName,
  }) = _TraderFilterUiModel;
}
