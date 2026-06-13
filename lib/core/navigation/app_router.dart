import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: SplashRoute.page,
          path: '/splash',
        ),
        AutoRoute(
          page: TarkovShellRoute.page,
          path: '/darkoff',
          children: [
            AutoRoute(page: HomeRoute.page, path: '', initial: true),
            AutoRoute(
              page: ItemsShellRoute.page,
              path: 'items',
              children: [
                AutoRoute(
                  page: ItemsRoute.page,
                  path: '',
                  initial: true,
                ),
                CustomRoute(
                  page: ItemsSearchRoute.page,
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return SlideTransition(
                      position: Tween(
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
                AutoRoute(
                  page: ItemDetailRoute.page,
                  path: 'detail',
                ),
              ],
            ),
            AutoRoute(page: MapsRoute.page, path: 'maps'),
            AutoRoute(page: TasksRoute.page, path: 'tasks'),
            AutoRoute(page: MoreRoute.page, path: 'more'),
          ],
        ),
      ];
}
