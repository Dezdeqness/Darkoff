import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/theme/themes/color_theme.dart';
import 'package:darkoff/presentation/features/refresh/notifiers/refresh_notifier.dart';
import 'package:darkoff/presentation/features/refresh/state/refresh_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class TarkovShellScreen extends ConsumerStatefulWidget {
  const TarkovShellScreen({super.key});

  @override
  ConsumerState<TarkovShellScreen> createState() => _TarkovShellScreenState();
}

class _TarkovShellScreenState extends ConsumerState<TarkovShellScreen> {
  StreamSubscription<RefreshEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription =
        ref.read(refreshProvider.notifier).events.listen(_onRefreshEvent);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      homeIndex: 0,
      routes: const [
        HomeRoute(),
        ItemsShellRoute(),
        MapsRoute(),
        TasksShellRoute(),
        MoreShellRoute(),
      ],
      bottomNavigationBuilder: (ctx, tabsRouter) =>
          _BottomNav(tabsRouter: tabsRouter),
    );
  }

  void _onRefreshEvent(RefreshEvent event) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    event.when(
      started: () => messenger.showSnackBar(
        SnackBar(content: Text(tr.shell.refresh.refreshing)),
      ),
      progress: (loaded) => messenger.showSnackBar(
        SnackBar(content: Text(tr.shell.refresh.progress(loaded: loaded))),
      ),
      completed: () => messenger.showSnackBar(
        SnackBar(content: Text(tr.shell.refresh.success)),
      ),
      error: (msg) => messenger.showSnackBar(
        SnackBar(content: Text(tr.shell.refresh.failed(error: msg))),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.tabsRouter});

  final TabsRouter tabsRouter;

  static final _items = <_NavItemData>[
    _NavItemData(icon: Icons.home_outlined, label: () => tr.nav.home),
    _NavItemData(icon: Icons.grid_view_rounded, label: () => tr.nav.items),
    _NavItemData(icon: Icons.map_outlined, label: () => tr.nav.maps),
    _NavItemData(icon: Icons.checklist_outlined, label: () => tr.nav.tasks),
    _NavItemData(icon: Icons.more_horiz, label: () => tr.nav.more),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;

    return Container(
      decoration: BoxDecoration(
        color: colors.navBackground,
        border: Border(top: BorderSide(color: colors.navBorder)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (i) {
              return _NavItem(
                data: _items[i],
                isActive: tabsRouter.activeIndex == i,
                onTap: () => tabsRouter.setActiveIndex(i),
                colors: colors,
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavItemData {
  const _NavItemData({required this.icon, required this.label});
  final IconData icon;
  final String Function() label;
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.data,
    required this.isActive,
    required this.onTap,
    required this.colors,
  });

  final _NavItemData data;
  final bool isActive;
  final VoidCallback onTap;
  final ColorTheme colors;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? colors.gold : colors.textTertiary;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data.icon, color: color, size: 22),
            const SizedBox(height: 4),
            Text(
              data.label(),
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight:
                    isActive ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
