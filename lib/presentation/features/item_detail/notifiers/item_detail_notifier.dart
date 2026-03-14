import 'dart:async';

import 'package:darkoff/domain/usecases/get_item_detail_usecase.dart';
import 'package:darkoff/presentation/features/item_detail/mapper/item_detail_ui_mapper.dart';
import 'package:darkoff/presentation/features/item_detail/state/item_detail_state.dart';
import 'package:darkoff/service_locator/items_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'item_detail_notifier.g.dart';

@riverpod
class ItemDetailNotifier extends _$ItemDetailNotifier {
  late final GetItemDetailUseCase _useCase;
  late final ItemDetailUiMapper _mapper;
  late final String _itemId;
  StreamSubscription<void>? _subscription;

  @override
  ItemDetailState build(String itemId) {
    _useCase = getIt<GetItemDetailUseCase>();
    _mapper = getIt<ItemDetailUiMapper>();
    _itemId = itemId;

    ref.onDispose(() {
      _subscription?.cancel();
      _subscription = null;
    });

    _loadDetail();
    return const ItemDetailState.loading();
  }

  void _loadDetail() {
    state = const ItemDetailState.loading();

    _subscription?.cancel();
    _subscription = _useCase(_itemId).listen(
      (result) {
        result.fold(
          (detail) {
            state = ItemDetailState.loaded(_mapper.fromEntity(detail));
          },
          (error) {
            if (state is! ItemDetailLoaded) {
              state = ItemDetailState.error(error.toString());
            }
          },
        );
      },
      onError: (Object e) {
        if (state is! ItemDetailLoaded) {
          state = ItemDetailState.error(e.toString());
        }
      },
    );
  }

  void retry() {
    _loadDetail();
  }

}
