import 'package:darkoff/presentation/features/items/model/item_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'items_search_state.freezed.dart';

@freezed
class ItemsSearchState with _$ItemsSearchState {
  const factory ItemsSearchState.initial() = Initial;
  const factory ItemsSearchState.loading() = Loading;
  const factory ItemsSearchState.empty() = Empty;
  const factory ItemsSearchState.loaded({
    required List<ItemUiModel> items,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isRefreshing,
  }) = Loaded;
  const factory ItemsSearchState.error(String message) = Error;
}