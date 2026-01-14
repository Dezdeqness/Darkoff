import 'package:darkoff/presentation/features/categories/model/category_ui_model.dart';
import 'package:darkoff/presentation/features/categories/widgets/category_card.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final String header;
  final List<CategoryUiModel> items;
  final Function(CategoryUiModel) onItemTap;

  const CategorySection({
    super.key,
    required this.header,
    required this.items,
    required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Text(
            header,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return CategoryCard(
              imageUrl: item.imageUrl,
              title: item.displayText,
              onTap: () => onItemTap(item),
            );
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
