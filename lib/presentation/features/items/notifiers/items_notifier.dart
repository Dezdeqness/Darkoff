import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:darkoff/presentation/features/items/mapper/item_ui_mapper.dart';
import 'package:darkoff/presentation/features/items/state/items_state.dart';
import 'package:darkoff/service_locator/items_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'items_notifier.g.dart';

@riverpod
class ItemsNotifier extends _$ItemsNotifier {
  late ItemsRepository _repository;
  late ItemUiMapper _mapper;
  List<String> _currentCategoryNames = const [];

  @override
  ItemsState build(List<String> categoryNames) {
    _repository = getIt<ItemsRepository>();
    _mapper = getIt<ItemUiMapper>();
    _currentCategoryNames = categoryNames;
    loadItems();
    return const ItemsState.initial();
  }

  Future<void> loadItems({bool isRefresh = false}) async {
    if (isRefresh) {
      state = const ItemsState.loading();
    }

    try {
      final result = await _repository.getLocalItems(
        categoryNames: _currentCategoryNames,
      );

      result.fold(
        (items) {
          if (items.isEmpty) {
            state = const ItemsState.empty();
          } else {
            state = ItemsState.loaded(
              items: _mapper.fromEntities(items),
              hasMore: false,
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

  Future<void> refresh() async {
    final currentState = state;

    if (currentState is Loaded) {
      state = currentState.copyWith(isRefreshing: true);
    }

    await loadItems(isRefresh: true);
  }
}
