import 'package:freezed_annotation/freezed_annotation.dart';

part 'boss_list_ui_model.freezed.dart';

@freezed
abstract class BossListItemUiModel with _$BossListItemUiModel {
  const factory BossListItemUiModel({
    required String id,
    required String name,
    String? portraitUrl,
    String? healthLabel,
    @Default([]) List<String> mapLabels,
  }) = _BossListItemUiModel;
}
