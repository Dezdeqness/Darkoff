// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:collection/collection.dart' as _i12;
import 'package:darkoff/core/navigation/shells/tarkov_shell_page.dart' as _i7;
import 'package:darkoff/domain/entities/item_type.dart' as _i11;
import 'package:darkoff/presentation/features/categories/categories_page.dart'
    as _i1;
import 'package:darkoff/presentation/features/home/home_page.dart' as _i2;
import 'package:darkoff/presentation/features/items/items_page.dart' as _i3;
import 'package:darkoff/presentation/features/items/items_shell_route.dart'
    as _i4;
import 'package:darkoff/presentation/features/maps/maps_page.dart' as _i5;
import 'package:darkoff/presentation/features/more/more_page.dart' as _i6;
import 'package:darkoff/presentation/features/tasks/tasks_page.dart' as _i8;
import 'package:flutter/material.dart' as _i10;

/// generated route for
/// [_i1.CategoriesPage]
class CategoriesRoute extends _i9.PageRouteInfo<void> {
  const CategoriesRoute({List<_i9.PageRouteInfo>? children})
      : super(CategoriesRoute.name, initialChildren: children);

  static const String name = 'CategoriesRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.CategoriesPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.ItemsPage]
class ItemsRoute extends _i9.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i10.Key? key,
    List<_i11.ItemType> types = const [],
    List<_i9.PageRouteInfo>? children,
  }) : super(
          ItemsRoute.name,
          args: ItemsRouteArgs(key: key, types: types),
          initialChildren: children,
        );

  static const String name = 'ItemsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>(
        orElse: () => const ItemsRouteArgs(),
      );
      return _i3.ItemsPage(key: args.key, types: args.types);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, this.types = const []});

  final _i10.Key? key;

  final List<_i11.ItemType> types;

  @override
  String toString() {
    return 'ItemsRouteArgs{key: $key, types: $types}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemsRouteArgs) return false;
    return key == other.key &&
        const _i12.ListEquality<_i11.ItemType>().equals(types, other.types);
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i12.ListEquality<_i11.ItemType>().hash(types);
}

/// generated route for
/// [_i4.ItemsShellRoute]
class ItemsShellRoute extends _i9.PageRouteInfo<void> {
  const ItemsShellRoute({List<_i9.PageRouteInfo>? children})
      : super(ItemsShellRoute.name, initialChildren: children);

  static const String name = 'ItemsShellRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.ItemsShellRoute();
    },
  );
}

/// generated route for
/// [_i5.MapsPage]
class MapsRoute extends _i9.PageRouteInfo<void> {
  const MapsRoute({List<_i9.PageRouteInfo>? children})
      : super(MapsRoute.name, initialChildren: children);

  static const String name = 'MapsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.MapsPage();
    },
  );
}

/// generated route for
/// [_i6.MorePage]
class MoreRoute extends _i9.PageRouteInfo<void> {
  const MoreRoute({List<_i9.PageRouteInfo>? children})
      : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.MorePage();
    },
  );
}

/// generated route for
/// [_i7.TarkovShellScreen]
class TarkovShellRoute extends _i9.PageRouteInfo<void> {
  const TarkovShellRoute({List<_i9.PageRouteInfo>? children})
      : super(TarkovShellRoute.name, initialChildren: children);

  static const String name = 'TarkovShellRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.TarkovShellScreen();
    },
  );
}

/// generated route for
/// [_i8.TasksPage]
class TasksRoute extends _i9.PageRouteInfo<void> {
  const TasksRoute({List<_i9.PageRouteInfo>? children})
      : super(TasksRoute.name, initialChildren: children);

  static const String name = 'TasksRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.TasksPage();
    },
  );
}
