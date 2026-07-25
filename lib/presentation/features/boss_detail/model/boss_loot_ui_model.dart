import 'package:freezed_annotation/freezed_annotation.dart';

part 'boss_loot_ui_model.freezed.dart';

@freezed
abstract class BossLootUiModel with _$BossLootUiModel {
  const factory BossLootUiModel({
    required String id,
    required String name,
    String? iconUrl,
    String? fleaPrice,
    String? traderPrice,
  }) = _BossLootUiModel;
}
