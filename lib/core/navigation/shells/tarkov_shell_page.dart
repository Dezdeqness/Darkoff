import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
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
    final notifier = ref.read(refreshProvider.notifier);
    _subscription = notifier.events.listen(_onRefreshEvent);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _onRefreshEvent(RefreshEvent event) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    event.when(
      started: () {
        messenger.showSnackBar(
          const SnackBar(content: Text('Refreshing items...')),
        );
      },
      progress: (loaded) {
        messenger.showSnackBar(
          SnackBar(content: Text('Loaded $loaded items...')),
        );
      },
      completed: () {
        messenger.showSnackBar(
          const SnackBar(content: Text('Items refreshed successfully')),
        );
      },
      error: (message) {
        messenger.showSnackBar(
          SnackBar(content: Text('Failed to refresh: $message')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRefreshing = ref.watch(refreshProvider);

    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        return AppBar(
          title: const Text('Darkoff'),
          actions: [
            IconButton(
              icon: isRefreshing
                  ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.refresh),
              tooltip: 'Refresh items',
              onPressed: isRefreshing
                  ? null
                  : () =>
                  ref
                      .read(refreshProvider.notifier)
                      .refresh(),
            ),
          ],
        );
      },
      routes: const [
        HomeRoute(),
        ItemsShellRoute(),
        MapsRoute(),
        TasksRoute(),
        MoreRoute(),
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return NavigationBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              selectedIcon: Icon(Icons.inventory_2),
              label: 'Items',
            ),
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map),
              label: 'Maps',
            ),
            NavigationDestination(
              icon: Icon(Icons.checklist_outlined),
              selectedIcon: Icon(Icons.checklist),
              label: 'Tasks',
            ),
            NavigationDestination(
              icon: Icon(Icons.more_horiz),
              selectedIcon: Icon(Icons.more_horiz),
              label: 'More',
            ),
          ],
        );
      },
    );
  }
}
