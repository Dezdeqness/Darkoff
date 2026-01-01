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
        AutoRoute(page: ItemsRoute.page, path: 'items'),
        AutoRoute(page: MapsRoute.page, path: 'maps'),
        AutoRoute(page: TasksRoute.page, path: 'tasks'),
        AutoRoute(page: MoreRoute.page, path: 'more'),
      ],
    ),
  ];
}
