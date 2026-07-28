import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(initial: true, page: SplashRoute.page, path: '/splash'),
    AutoRoute(
      page: TarkovShellRoute.page,
      path: '/darkoff',
      children: [
        AutoRoute(page: HomeRoute.page, path: '', initial: true),
        AutoRoute(
          page: ItemsShellRoute.page,
          path: 'items',
          children: [
            AutoRoute(page: ItemsRoute.page, path: '', initial: true),
            CustomRoute(
              page: ItemsSearchRoute.page,
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position:
                          Tween(
                            begin: const Offset(0, 0.05),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                      child: child,
                    );
                  },
            ),
            AutoRoute(page: ItemDetailRoute.page, path: 'detail'),
          ],
        ),
        AutoRoute(page: MapsRoute.page, path: 'maps'),
        AutoRoute(
          page: TasksShellRoute.page,
          path: 'tasks',
          children: [
            AutoRoute(page: TasksRoute.page, path: '', initial: true),
            CustomRoute(
              page: TasksSearchRoute.page,
              path: 'search',
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position:
                          Tween(
                            begin: const Offset(0, 0.05),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutCubic,
                            ),
                          ),
                      child: child,
                    );
                  },
            ),
            AutoRoute(page: TaskDetailRoute.page, path: ':taskId'),
          ],
        ),
        AutoRoute(
          page: MoreShellRoute.page,
          path: 'more',
          children: [
            AutoRoute(page: MoreRoute.page, path: '', initial: true),
            AutoRoute(page: HideoutRoute.page, path: 'hideout'),
            AutoRoute(page: HideoutDetailRoute.page, path: 'hideout/:detailId'),
            AutoRoute(page: ShoppingListRoute.page, path: 'hideout-shopping'),
            AutoRoute(page: AmmoRoute.page, path: 'ammo'),
            AutoRoute(page: TradersRoute.page, path: 'traders'),
            AutoRoute(
              page: TradersDetailRoute.page,
              path: 'traders/:traderId',
            ),
            AutoRoute(page: FleaMarketRoute.page, path: 'flea'),
            AutoRoute(page: BartersRoute.page, path: 'barters'),
            AutoRoute(page: CraftsRoute.page, path: 'crafts'),
            AutoRoute(page: BossesRoute.page, path: 'bosses'),
            AutoRoute(page: BossDetailRoute.page, path: 'bosses/:bossId'),
            AutoRoute(page: KeysRoute.page, path: 'keys'),
            AutoRoute(page: SettingsRoute.page, path: 'settings'),
          ],
        ),
      ],
    ),
    AutoRoute(page: ItemDetailRoute.page, path: '/item/:id'),
    AutoRoute(page: MapDetailRoute.page, path: '/map/:mapId'),
    AutoRoute(page: BossDetailRoute.page, path: '/boss/:bossId'),
  ];
}
