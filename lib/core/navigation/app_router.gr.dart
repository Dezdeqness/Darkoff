// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:darkoff/core/navigation/shells/tarkov_shell_page.dart' as _i5;
import 'package:darkoff/presentation/features/home/home_page.dart' as _i1;
import 'package:darkoff/presentation/features/items/items_page.dart' as _i2;
import 'package:darkoff/presentation/features/maps/maps_page.dart' as _i3;
import 'package:darkoff/presentation/features/more/more_page.dart' as _i4;
import 'package:darkoff/presentation/features/tasks/tasks_page.dart' as _i6;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.ItemsPage]
class ItemsRoute extends _i7.PageRouteInfo<void> {
  const ItemsRoute({List<_i7.PageRouteInfo>? children})
      : super(ItemsRoute.name, initialChildren: children);

  static const String name = 'ItemsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.ItemsPage();
    },
  );
}

/// generated route for
/// [_i3.MapsPage]
class MapsRoute extends _i7.PageRouteInfo<void> {
  const MapsRoute({List<_i7.PageRouteInfo>? children})
      : super(MapsRoute.name, initialChildren: children);

  static const String name = 'MapsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.MapsPage();
    },
  );
}

/// generated route for
/// [_i4.MorePage]
class MoreRoute extends _i7.PageRouteInfo<void> {
  const MoreRoute({List<_i7.PageRouteInfo>? children})
      : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.MorePage();
    },
  );
}

/// generated route for
/// [_i5.TarkovShellScreen]
class TarkovShellRoute extends _i7.PageRouteInfo<void> {
  const TarkovShellRoute({List<_i7.PageRouteInfo>? children})
      : super(TarkovShellRoute.name, initialChildren: children);

  static const String name = 'TarkovShellRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.TarkovShellScreen();
    },
  );
}

/// generated route for
/// [_i6.TasksPage]
class TasksRoute extends _i7.PageRouteInfo<void> {
  const TasksRoute({List<_i7.PageRouteInfo>? children})
      : super(TasksRoute.name, initialChildren: children);

  static const String name = 'TasksRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.TasksPage();
    },
  );
}
