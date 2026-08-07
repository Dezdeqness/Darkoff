import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/items/state/categories_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/category_ui_model.dart';

part 'categories_notifier.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  CategoriesState build() {
    return CategoriesState(
      categories: [
        CategoryUiModel(label: tr.common.filter.all, names: const []),
        CategoryUiModel(label: tr.items.filter.keys, names: const ['keys', 'key']),
        CategoryUiModel(label: tr.items.filter.meds, names: const ['meds', 'medical-supplies']),
        CategoryUiModel(label: tr.items.filter.ammo, names: const ['ammo', 'ammo-container']),
        CategoryUiModel(
          label: tr.items.filter.gear,
          names: const [
            'headwear',
            'armor',
            'armor-plate',
            'chest-rig',
            'backpack',
            'headphones',
            'face-cover',
            'vis-observ-device',
          ],
        ),
      ],
    );
  }

  void selectCategory(int index) {
    state = state.copyWith(selectedIndex: index);
  }
}
