import 'package:freezed_annotation/freezed_annotation.dart';

part 'ammo_list_ui_model.freezed.dart';

enum AmmoPenTier { high, mid, low }

@freezed
abstract class AmmoListUiModel with _$AmmoListUiModel {
  const factory AmmoListUiModel({
    @Default([]) List<AmmoCaliberOption> calibers,
    String? selectedCaliber,
    @Default('') String sortLabel,
    @Default(false) bool grouped,
    @Default([]) List<AmmoGroupUiModel> groups,
    @Default([]) List<AmmoRowUiModel> rows,
  }) = _AmmoListUiModel;

  const AmmoListUiModel._();

  bool get isEmpty => grouped ? groups.isEmpty : rows.isEmpty;
}

@freezed
abstract class AmmoCaliberOption with _$AmmoCaliberOption {
  const factory AmmoCaliberOption({
    required String value,
    required String label,
  }) = _AmmoCaliberOption;
}

@freezed
abstract class AmmoGroupUiModel with _$AmmoGroupUiModel {
  const factory AmmoGroupUiModel({
    required String caliberLabel,
    @Default([]) List<AmmoRowUiModel> rows,
  }) = _AmmoGroupUiModel;
}

@freezed
abstract class AmmoRowUiModel with _$AmmoRowUiModel {
  const factory AmmoRowUiModel({
    required String id,
    required String shortName,
    required String damage,
    required String penetration,
    @Default('') String trailingLabel,
    required AmmoPenTier penTier,
    @Default(false) bool tracer,
  }) = _AmmoRowUiModel;
}
