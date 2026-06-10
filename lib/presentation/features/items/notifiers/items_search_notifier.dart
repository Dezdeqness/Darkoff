import 'dart:async';

import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:darkoff/presentation/features/items/state/items_search_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:darkoff/service_locator/items_service_locator.dart';

part 'items_search_notifier.g.dart';

@riverpod
class ItemsSearchNotifier extends _$ItemsSearchNotifier {
  late ItemsRepository _repository;
  Timer? _debounce;

  String _lastQuery = '';

  @override
  ItemsSearchState build() {
    _repository = getIt<ItemsRepository>();
    return const ItemsSearchState.initial();
  }

  void onQueryChanged(String query) {
    _lastQuery = query;
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      _search(query);
    });
  }

  Future<void> refresh() async {
    await _search(_lastQuery);
  }


  Future<void> _search(String query) async {
    if (query.isEmpty) {
      state = const ItemsSearchState.initial();
      return;
    }

    state = const ItemsSearchState.loading();

    final result = await _repository.searchItems(query: query);

    result.fold(
          (items) {
        if (items.isEmpty) {
          state = const ItemsSearchState.empty();
        } else {
          state = ItemsSearchState.loaded(
            items: items.map((e) => e.toString()).toList(),
            hasMore: false,
            isRefreshing: false,
          );
        }
      },
          (error) {
        state = ItemsSearchState.error(error.toString());
      },
    );
  }

  void clear() {
    _debounce?.cancel();
    _lastQuery = '';
  }
}
