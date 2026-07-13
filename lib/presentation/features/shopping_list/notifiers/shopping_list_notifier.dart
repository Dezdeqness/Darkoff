import 'package:darkoff/presentation/features/hideout/notifiers/hideout_notifier.dart';
import 'package:darkoff/presentation/features/hideout/notifiers/hideout_progress_notifier.dart';
import 'package:darkoff/presentation/features/hideout/state/hideout_state.dart';
import 'package:darkoff/presentation/features/shopping_list/mapper/shopping_list_ui_mapper.dart';
import 'package:darkoff/presentation/features/shopping_list/state/shopping_list_state.dart';
import 'package:darkoff/service_locator/hideout_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shopping_list_notifier.g.dart';

@riverpod
class ShoppingListNotifier extends _$ShoppingListNotifier {
  late ShoppingListUiMapper _mapper;

  @override
  ShoppingListState build() {
    _mapper = getIt<ShoppingListUiMapper>();

    final state = ref.watch(hideoutProvider);
    final progress = ref.watch(hideoutProgressProvider);

    return state.maybeWhen(
      loaded: (stations) {
        final model = _mapper.toModel(stations, progress);
        return model.rows.isEmpty
            ? const ShoppingListState.empty()
            : ShoppingListState.loaded(model);
      },
      loading: () => const ShoppingListState.loading(),
      initial: () => const ShoppingListState.loading(),
      orElse: () => const ShoppingListState.empty(),
    );
  }
}
