import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          initial: true,
          page: TarkovShellRoute.page,
          path: '/darkoff',
          children: [
            AutoRoute(page: HomeRoute.page, path: '', initial: true),
            AutoRoute(
              page: ItemsShellRoute.page,
              path: 'items',
              children: [
                AutoRoute(
                  page: CategoriesRoute.page,
                  path: 'categories',
                  initial: true,
                ),
                AutoRoute(
                  page: ItemsRoute.page,
                  path: 'list',
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
