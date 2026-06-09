import 'package:darkoff/presentation/features/items/state/categories_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../model/category_ui_model.dart';

part 'categories_notifier.g.dart';

@riverpod
class CategoriesNotifier extends _$CategoriesNotifier {
  @override
  CategoriesState build() {
    return CategoriesState(
      categories: const [
        CategoryUiModel(label: 'All', names: []),
        CategoryUiModel(label: 'Keys', names: ['keys', 'key']),
        CategoryUiModel(label: 'Meds', names: ['meds', 'medical-supplies']),
        CategoryUiModel(label: 'Ammo', names: ['ammo', 'ammo-container']),
        CategoryUiModel(
          label: 'Gear',
          names: [
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
