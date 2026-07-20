import 'package:darkoff/presentation/features/flea_market/model/flea_item_ui_model.dart';
import 'package:darkoff/presentation/features/flea_market/notifiers/flea_notifier.dart';
import 'package:darkoff/presentation/features/flea_market/state/flea_category_state.dart';
import 'package:darkoff/presentation/features/flea_market/state/flea_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flea_category_notifier.g.dart';

enum FleaCategory { gainers, losers, expensive }

@riverpod
class FleaCategoryNotifier extends _$FleaCategoryNotifier {
  @override
  FleaCategoryState build(FleaCategory category) {
    final state = ref.watch(fleaProvider);

    return switch (state) {
      FleaLoaded(:final items) => _onLoaded(items, category),
      FleaError(:final message) => FleaCategoryState.error(message),
      _ => const FleaCategoryState.loading(),
    };
  }

  FleaCategoryState _onLoaded(
    List<FleaItemUiModel> items,
    FleaCategory category,
  ) {
    final filtered = items.where((item) => (item.avgPrice) > 0).toList();

    final filteredCategory = _filterByCategory(filtered, category);

    if (filteredCategory.isNotEmpty) {
      return FleaCategoryState.loaded(filteredCategory);
    } else {
      return const FleaCategoryState.error('Items not found');
    }
  }

  List<FleaItemUiModel> _filterByCategory(
    List<FleaItemUiModel> items,
    FleaCategory category,
  ) {
    return switch (category) {
      FleaCategory.gainers =>
        (items..sort((a, b) => b.changePercent.compareTo(a.changePercent)))
            .take(100)
            .toList(),
      FleaCategory.losers =>
        (items..sort((a, b) => a.changePercent.compareTo(b.changePercent)))
            .take(100)
            .toList(),
      FleaCategory.expensive =>
        (items..sort((a, b) => (b.avgPrice).compareTo(a.avgPrice)))
            .take(100)
            .toList(),
    };
  }

  Future<void> refresh() => ref.read(fleaProvider.notifier).refresh();
}
