import 'package:freezed_annotation/freezed_annotation.dart';

part 'keys_list_ui_model.freezed.dart';

enum KeySort { name, priceDesc, priceAsc }

@freezed
abstract class KeysListUiModel with _$KeysListUiModel {
  const factory KeysListUiModel({
    @Default([]) List<KeySortChipUiModel> sortChips,
    @Default([]) List<KeyRowUiModel> rows,
  }) = _KeysListUiModel;

  const KeysListUiModel._();

  bool get isEmpty => rows.isEmpty;
}

@freezed
abstract class KeySortChipUiModel with _$KeySortChipUiModel {
  const factory KeySortChipUiModel({
    required KeySort value,
    required String label,
    @Default(false) bool active,
  }) = _KeySortChipUiModel;
}

@freezed
abstract class KeyRowUiModel with _$KeyRowUiModel {
  const factory KeyRowUiModel({
    required String id,
    String? iconLink,
    required String name,
    String? categoryLabel,
    required String priceLabel,
    @Default(false) bool hasPrice,
    String? lowPriceLabel,
  }) = _KeyRowUiModel;
}
