import 'package:auto_route/auto_route.dart';

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
                AutoRoute(
                  page: ItemsSearchRoute.page,
                  path: 'search',
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
