import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/categories/model/category_ui_model.dart';
import 'package:darkoff/presentation/features/categories/model/category_ui_section.dart';
import 'package:darkoff/presentation/features/categories/notifiers/category_notifier.dart';
import 'package:darkoff/presentation/features/categories/state/category_state.dart';
import 'package:darkoff/presentation/features/categories/widgets/category_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(categoryProvider);

    return Scaffold(
      body: SafeArea(
        child: state.when(
          initial: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (sections) => _buildCategoriesList(context, sections),
        ),
      ),
    );
  }

  Widget _buildCategoriesList(BuildContext context, List<CategoryUiSection> sections) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          title: Text('Categories'),
          floating: true,
          snap: true,
          pinned: false,
        ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 8.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final section = sections[index];
                return CategorySection(
                  header: section.header,
                  items: section.items,
                  onItemTap: (item) => _onCategoryTap(context, item),
                );
              },
              childCount: sections.length,
            ),
          ),
        ),
      ],
    );
  }

  void _onCategoryTap(BuildContext context, CategoryUiModel item) {
    context.router.push(ItemsRoute(types: item.types));
  }
}
