import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/more/model/more_menu.dart';
import 'package:darkoff/presentation/features/more/notifiers/more_menu_notifier.dart';
import 'package:darkoff/presentation/features/more/widgets/more_menu_row.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  VoidCallback? onTapFor(BuildContext context, MoreMenuEntry entry) {
    return switch (entry) {
      MoreMenuEntry.hideout => () => context.router.push(const HideoutRoute()),
      MoreMenuEntry.traders => () => context.router.push(const TradersRoute()),
      MoreMenuEntry.fleaMarket => () => context.router.push(const FleaMarketRoute()),
      MoreMenuEntry.bosses => () => context.router.push(const BossesRoute()),
      MoreMenuEntry.ammoChart => () => context.router.push(const AmmoRoute()),
      MoreMenuEntry.keys => () => context.router.push(const KeysRoute()),
      MoreMenuEntry.crafts => () => context.router.push(const CraftsRoute()),
      MoreMenuEntry.barters => () => context.router.push(const BartersRoute()),
      MoreMenuEntry.settings => () => context.router.push(const SettingsRoute()),
      MoreMenuEntry.about => () => (),
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
                title: tr.more.title,
                subtitle: tr.more.subtitle,
                showBack: false,
              ),
            ),
            for (final section in sections) ...[
              SliverToBoxAdapter(
                child: SectionLabel(section.section.title),
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
