import 'package:darkoff/presentation/features/items/model/item_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'items_state.freezed.dart';

@freezed
class ItemsState with _$ItemsState {
  const factory ItemsState.initial() = Initial;
  const factory ItemsState.loading() = Loading;
  const factory ItemsState.empty() = Empty;
  const factory ItemsState.loaded({
    required List<ItemUiModel> items,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
  }) = Loaded;
  const factory ItemsState.error(String message) = Error;
}