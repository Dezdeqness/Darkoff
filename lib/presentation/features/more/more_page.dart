import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/app_translations.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/core/widgets/section_label.dart';
import 'package:darkoff/presentation/features/more/model/more_menu.dart';
import 'package:darkoff/presentation/features/more/notifiers/more_menu_notifier.dart';
import 'package:darkoff/presentation/features/more/widgets/more_menu_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  VoidCallback? onTapFor(BuildContext context, MoreMenuEntry entry) {
    return switch (entry) {
      MoreMenuEntry.hideout => () => context.router.push(const HideoutRoute()),
      _ => null,
    };
  }

  Widget buildSection({
    required BuildContext context,
    required List<MoreMenuEntry> entries,
  }) {
    final colors = context.colorTheme;
    final shape = context.shapeTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: shape.radiusMD,
        ),
        child: Column(
          children: [
            for (var i = 0; i < entries.length; i++)
              MoreMenuRow(
                entry: entries[i],
                onTap: onTapFor(context, entries[i]),
                showDivider: i != entries.length - 1,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final sections = ref.watch(moreMenuProvider);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PageHeader(
                title: 'more.title'.i18n,
                subtitle: 'more.subtitle'.i18n,
                showBack: false,
              ),
            ),
            for (final section in sections) ...[
              SliverToBoxAdapter(
                child: SectionLabel(section.section.titleKey.i18n),
              ),
              SliverToBoxAdapter(
                child: buildSection(context: context, entries: section.entries),
              ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: 32)),
          ],
        ),
      ),
    );
  }
}
