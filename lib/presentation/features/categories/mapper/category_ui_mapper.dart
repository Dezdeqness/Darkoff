import 'package:darkoff/data/providers/category_data_provider.dart';
import 'package:darkoff/domain/entities/category_entity.dart';
import 'package:darkoff/presentation/features/categories/model/category_ui_model.dart';
import 'package:darkoff/presentation/features/categories/model/category_ui_section.dart';

class CategoryUiMapper {
  List<CategoryUiSection> mapToSections(
    Map<String, List<CategoryEntity>> categoriesMap,
  ) {
    final orderedKeys = [
      (categoryKeyGear, 'Gear'),
      (categoryKeyWeaponry, 'Weaponry'),
      (categoryKeyOther, 'Other Stuff'),
    ];

    return orderedKeys.map((entry) {
      final key = entry.$1;
      final header = entry.$2;
      final entities = categoriesMap[key] ?? [];

      return CategoryUiSection(
        key: key,
        header: header,
        items: entities.map(_entityToUiModel).toList(),
      );
    }).toList();
  }

  CategoryUiModel _entityToUiModel(CategoryEntity entity) {
    return CategoryUiModel(
      key: entity.key,
      displayText: entity.displayText,
      // TODO: env variables
      imageUrl: 'https://tarkov.dev/images/items/${entity.key}-table_thumb.jpg',
    );
  }
}
