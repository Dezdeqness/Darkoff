import 'package:darkoff/domain/entities/item_type.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:darkoff/data/utils/item_type_mapper.dart';
import 'package:darkoff/presentation/features/items/mapper/item_ui_mapper.dart';
import 'package:darkoff/presentation/features/items/state/items_state.dart';
import 'package:darkoff/service_locator/items_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'items_notifier.g.dart';

@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  static const int _pageSize = 50;
  int _currentOffset = 0;
  List<ItemType> _currentTypes = const [];

  late ItemsRepository _repository;
  late ItemUiMapper _mapper;

  @override
  ItemsState build(List<ItemType> types) {
    _repository = getIt<ItemsRepository>();
    _mapper = getIt<ItemUiMapper>();
    _currentTypes = types;
    _currentOffset = 0;
    loadItems();
    return const ItemsState.initial();
  }

  Future<void> loadItems({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentOffset = 0;
      state = const ItemsState.loading();
    }

    try {
      final result = await _repository.getItems(
        limit: _pageSize,
        offset: _currentOffset,
        types: _currentTypes.map((type) => type.toGraphqlEnum()).toList(),
      );

      result.fold(
        (items) {
          if (items.isEmpty) {
            state = const ItemsState.empty();
          } else {
            state = ItemsState.loaded(
              items: _mapper.fromEntities(items),
              hasMore: items.length == _pageSize,
              isRefreshing: false,
            );
          }
        },
        (error) {
          state = ItemsState.error(error.toString());
        },
      );
    } catch (e) {
      state = ItemsState.error(e.toString());
    }
  }

  Future<void> loadMoreItems() async {
    final currentState = state;

    if (currentState is! Loaded ||
        currentState.isLoadingMore ||
        !currentState.hasMore) {
      return;
    }

    state = currentState.copyWith(isLoadingMore: true);

    try {
      final result = await _repository.getItems(
        limit: _pageSize,
        offset: _currentOffset,
        types: _currentTypes.map((type) => type.toGraphqlEnum()).toList(),
      );

      result.fold(
        (newItems) {
          final allItems = [
            ...currentState.items,
            ..._mapper.fromEntities(newItems),
          ];

          _currentOffset += newItems.length;

          state = currentState.copyWith(
            items: allItems,
            hasMore: newItems.length == _pageSize,
            isLoadingMore: false,
          );
        },
        (error) {
          state = currentState.copyWith(isLoadingMore: false);
        },
      );
    } catch (e) {
      state = currentState.copyWith(isLoadingMore: false);
    }
  }

  Future<void> refresh() async {
    final currentState = state;

    if (currentState is Loaded) {
      state = currentState.copyWith(isRefreshing: true);
    }

    await loadItems(isRefresh: true);
  }
}
