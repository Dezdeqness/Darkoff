// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:collection/collection.dart' as _i13;
import 'package:darkoff/core/navigation/shells/tarkov_shell_page.dart' as _i9;
import 'package:darkoff/presentation/features/categories/categories_page.dart'
    as _i1;
import 'package:darkoff/presentation/features/home/home_page.dart' as _i2;
import 'package:darkoff/presentation/features/item_detail/item_detail_page.dart'
    as _i3;
import 'package:darkoff/presentation/features/items/items_page.dart' as _i4;
import 'package:darkoff/presentation/features/items/items_shell_route.dart'
    as _i5;
import 'package:darkoff/presentation/features/maps/maps_page.dart' as _i6;
import 'package:darkoff/presentation/features/more/more_page.dart' as _i7;
import 'package:darkoff/presentation/features/splash/splash_page.dart' as _i8;
import 'package:darkoff/presentation/features/tasks/tasks_page.dart' as _i10;
import 'package:flutter/material.dart' as _i12;

/// generated route for
/// [_i1.CategoriesPage]
class CategoriesRoute extends _i11.PageRouteInfo<void> {
  const CategoriesRoute({List<_i11.PageRouteInfo>? children})
    : super(CategoriesRoute.name, initialChildren: children);

  static const String name = 'CategoriesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.CategoriesPage();
    },
  );
}

/// generated route for
/// [_i2.HomePage]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomePage();
    },
  );
}

/// generated route for
/// [_i3.ItemDetailPage]
class ItemDetailRoute extends _i11.PageRouteInfo<ItemDetailRouteArgs> {
  ItemDetailRoute({
    _i12.Key? key,
    required String itemId,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ItemDetailRoute.name,
         args: ItemDetailRouteArgs(key: key, itemId: itemId),
         rawPathParams: {'id': itemId},
         initialChildren: children,
       );

  static const String name = 'ItemDetailRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ItemDetailRouteArgs>(
        orElse: () => ItemDetailRouteArgs(itemId: pathParams.getString('id')),
      );
      return _i3.ItemDetailPage(key: args.key, itemId: args.itemId);
    },
  );
}

class ItemDetailRouteArgs {
  const ItemDetailRouteArgs({this.key, required this.itemId});

  final _i12.Key? key;

  final String itemId;

  @override
  String toString() {
    return 'ItemDetailRouteArgs{key: $key, itemId: $itemId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemDetailRouteArgs) return false;
    return key == other.key && itemId == other.itemId;
  }

  @override
  int get hashCode => key.hashCode ^ itemId.hashCode;
}

/// generated route for
/// [_i4.ItemsPage]
class ItemsRoute extends _i11.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i12.Key? key,
    List<String> categoryNames = const [],
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ItemsRoute.name,
         args: ItemsRouteArgs(key: key, categoryNames: categoryNames),
         initialChildren: children,
       );

  static const String name = 'ItemsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>(
        orElse: () => const ItemsRouteArgs(),
      );
      return _i4.ItemsPage(key: args.key, categoryNames: args.categoryNames);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, this.categoryNames = const []});

  final _i12.Key? key;

  final List<String> categoryNames;

  @override
  String toString() {
    return 'ItemsRouteArgs{key: $key, categoryNames: $categoryNames}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ItemsRouteArgs) return false;
    return key == other.key &&
        const _i13.ListEquality<String>().equals(
          categoryNames,
          other.categoryNames,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i13.ListEquality<String>().hash(categoryNames);
}

/// generated route for
/// [_i5.ItemsShellRoute]
class ItemsShellRoute extends _i11.PageRouteInfo<void> {
  const ItemsShellRoute({List<_i11.PageRouteInfo>? children})
    : super(ItemsShellRoute.name, initialChildren: children);

  static const String name = 'ItemsShellRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.ItemsShellRoute();
    },
  );
}

/// generated route for
/// [_i6.MapsPage]
class MapsRoute extends _i11.PageRouteInfo<void> {
  const MapsRoute({List<_i11.PageRouteInfo>? children})
    : super(MapsRoute.name, initialChildren: children);

  static const String name = 'MapsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.MapsPage();
    },
  );
}

/// generated route for
/// [_i7.MorePage]
class MoreRoute extends _i11.PageRouteInfo<void> {
  const MoreRoute({List<_i11.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.MorePage();
    },
  );
}

/// generated route for
/// [_i8.SplashPage]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.SplashPage();
    },
  );
}

/// generated route for
/// [_i9.TarkovShellScreen]
class TarkovShellRoute extends _i11.PageRouteInfo<void> {
  const TarkovShellRoute({List<_i11.PageRouteInfo>? children})
    : super(TarkovShellRoute.name, initialChildren: children);

  static const String name = 'TarkovShellRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.TarkovShellScreen();
    },
  );
}

/// generated route for
/// [_i10.TasksPage]
class TasksRoute extends _i11.PageRouteInfo<void> {
  const TasksRoute({List<_i11.PageRouteInfo>? children})
    : super(TasksRoute.name, initialChildren: children);

  static const String name = 'TasksRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.TasksPage();
    },
  );
}
