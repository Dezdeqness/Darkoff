import 'package:darkoff/core/config/app_config.dart';
import 'package:darkoff/data/providers/category_data_provider.dart';
import 'package:darkoff/domain/entities/category_entity.dart';
import 'package:darkoff/presentation/features/categories/model/category_ui_model.dart';
import 'package:darkoff/presentation/features/categories/model/category_ui_section.dart';

const kCategoryKeyGear = 'gear';
const kCategoryKeyWeaponry = 'weaponry';
const kCategoryKeyOther = 'other_stuff';

class CategoryUiMapper {
  List<CategoryUiSection> mapToSections(
    Map<String, List<CategoryEntity>> categoriesMap,
  ) {
    final orderedKeys = [
      (kCategoryKeyGear, 'Gear'),
      (kCategoryKeyWeaponry, 'Weaponry'),
      (kCategoryKeyOther, 'Other Stuff'),
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
      imageUrl: '${AppConfig.imagesBaseUrl}/items/${entity.key}-table_thumb.jpg',
      types: entity.types,
    );
  }
}
