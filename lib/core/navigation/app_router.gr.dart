// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:collection/collection.dart' as _i19;
import 'package:darkoff/core/navigation/shells/tarkov_shell_page.dart' as _i12;
import 'package:darkoff/presentation/features/categories/categories_page.dart'
    as _i1;
import 'package:darkoff/presentation/features/hideout/hideout_page.dart' as _i2;
import 'package:darkoff/presentation/features/home/home_page.dart' as _i3;
import 'package:darkoff/presentation/features/item_detail/item_detail_page.dart'
    as _i4;
import 'package:darkoff/presentation/features/items/items_page.dart' as _i5;
import 'package:darkoff/presentation/features/items/items_search_page.dart'
    as _i6;
import 'package:darkoff/presentation/features/items/items_shell_route.dart'
    as _i7;
import 'package:darkoff/presentation/features/maps/maps_page.dart' as _i8;
import 'package:darkoff/presentation/features/more/more_page.dart' as _i9;
import 'package:darkoff/presentation/features/more/more_shell_route.dart'
    as _i10;
import 'package:darkoff/presentation/features/splash/splash_page.dart' as _i11;
import 'package:darkoff/presentation/features/task_detail/task_detail_page.dart'
    as _i13;
import 'package:darkoff/presentation/features/tasks/tasks_page.dart' as _i14;
import 'package:darkoff/presentation/features/tasks/tasks_search_page.dart'
    as _i15;
import 'package:darkoff/presentation/features/tasks/tasks_shell_route.dart'
    as _i16;
import 'package:flutter/material.dart' as _i18;

/// generated route for
/// [_i1.CategoriesPage]
class CategoriesRoute extends _i17.PageRouteInfo<void> {
  const CategoriesRoute({List<_i17.PageRouteInfo>? children})
    : super(CategoriesRoute.name, initialChildren: children);

  static const String name = 'CategoriesRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i1.CategoriesPage();
    },
  );
}

/// generated route for
/// [_i2.HideoutPage]
class HideoutRoute extends _i17.PageRouteInfo<void> {
  const HideoutRoute({List<_i17.PageRouteInfo>? children})
    : super(HideoutRoute.name, initialChildren: children);

  static const String name = 'HideoutRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i2.HideoutPage();
    },
  );
}

/// generated route for
/// [_i3.HomePage]
class HomeRoute extends _i17.PageRouteInfo<void> {
  const HomeRoute({List<_i17.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.ItemDetailPage]
class ItemDetailRoute extends _i17.PageRouteInfo<ItemDetailRouteArgs> {
  ItemDetailRoute({
    _i18.Key? key,
    required String itemId,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         ItemDetailRoute.name,
         args: ItemDetailRouteArgs(key: key, itemId: itemId),
         rawPathParams: {'id': itemId},
         initialChildren: children,
       );

  static const String name = 'ItemDetailRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ItemDetailRouteArgs>(
        orElse: () => ItemDetailRouteArgs(itemId: pathParams.getString('id')),
      );
      return _i4.ItemDetailPage(key: args.key, itemId: args.itemId);
    },
  );
}

class ItemDetailRouteArgs {
  const ItemDetailRouteArgs({this.key, required this.itemId});

  final _i18.Key? key;

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
/// [_i5.ItemsPage]
class ItemsRoute extends _i17.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i18.Key? key,
    List<String> categoryNames = const [],
    List<_i17.PageRouteInfo>? children,
  }) : super(
         ItemsRoute.name,
         args: ItemsRouteArgs(key: key, categoryNames: categoryNames),
         initialChildren: children,
       );

  static const String name = 'ItemsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>(
        orElse: () => const ItemsRouteArgs(),
      );
      return _i5.ItemsPage(key: args.key, categoryNames: args.categoryNames);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, this.categoryNames = const []});

  final _i18.Key? key;

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
        const _i19.ListEquality<String>().equals(
          categoryNames,
          other.categoryNames,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i19.ListEquality<String>().hash(categoryNames);
}

/// generated route for
/// [_i6.ItemsSearchPage]
class ItemsSearchRoute extends _i17.PageRouteInfo<void> {
  const ItemsSearchRoute({List<_i17.PageRouteInfo>? children})
    : super(ItemsSearchRoute.name, initialChildren: children);

  static const String name = 'ItemsSearchRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i6.ItemsSearchPage();
    },
  );
}

/// generated route for
/// [_i7.ItemsShellRoute]
class ItemsShellRoute extends _i17.PageRouteInfo<void> {
  const ItemsShellRoute({List<_i17.PageRouteInfo>? children})
    : super(ItemsShellRoute.name, initialChildren: children);

  static const String name = 'ItemsShellRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i7.ItemsShellRoute();
    },
  );
}

/// generated route for
/// [_i8.MapsPage]
class MapsRoute extends _i17.PageRouteInfo<void> {
  const MapsRoute({List<_i17.PageRouteInfo>? children})
    : super(MapsRoute.name, initialChildren: children);

  static const String name = 'MapsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i8.MapsPage();
    },
  );
}

/// generated route for
/// [_i9.MorePage]
class MoreRoute extends _i17.PageRouteInfo<void> {
  const MoreRoute({List<_i17.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i9.MorePage();
    },
  );
}

/// generated route for
/// [_i10.MoreShellRoute]
class MoreShellRoute extends _i17.PageRouteInfo<void> {
  const MoreShellRoute({List<_i17.PageRouteInfo>? children})
    : super(MoreShellRoute.name, initialChildren: children);

  static const String name = 'MoreShellRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i10.MoreShellRoute();
    },
  );
}

/// generated route for
/// [_i11.SplashPage]
class SplashRoute extends _i17.PageRouteInfo<void> {
  const SplashRoute({List<_i17.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i11.SplashPage();
    },
  );
}

/// generated route for
/// [_i12.TarkovShellScreen]
class TarkovShellRoute extends _i17.PageRouteInfo<void> {
  const TarkovShellRoute({List<_i17.PageRouteInfo>? children})
    : super(TarkovShellRoute.name, initialChildren: children);

  static const String name = 'TarkovShellRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i12.TarkovShellScreen();
    },
  );
}

/// generated route for
/// [_i13.TaskDetailPage]
class TaskDetailRoute extends _i17.PageRouteInfo<TaskDetailRouteArgs> {
  TaskDetailRoute({
    _i18.Key? key,
    required String taskId,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         TaskDetailRoute.name,
         args: TaskDetailRouteArgs(key: key, taskId: taskId),
         rawPathParams: {'taskId': taskId},
         initialChildren: children,
       );

  static const String name = 'TaskDetailRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TaskDetailRouteArgs>(
        orElse: () =>
            TaskDetailRouteArgs(taskId: pathParams.getString('taskId')),
      );
      return _i13.TaskDetailPage(key: args.key, taskId: args.taskId);
    },
  );
}

class TaskDetailRouteArgs {
  const TaskDetailRouteArgs({this.key, required this.taskId});

  final _i18.Key? key;

  final String taskId;

  @override
  String toString() {
    return 'TaskDetailRouteArgs{key: $key, taskId: $taskId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TaskDetailRouteArgs) return false;
    return key == other.key && taskId == other.taskId;
  }

  @override
  int get hashCode => key.hashCode ^ taskId.hashCode;
}

/// generated route for
/// [_i14.TasksPage]
class TasksRoute extends _i17.PageRouteInfo<void> {
  const TasksRoute({List<_i17.PageRouteInfo>? children})
    : super(TasksRoute.name, initialChildren: children);

  static const String name = 'TasksRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i14.TasksPage();
    },
  );
}

/// generated route for
/// [_i15.TasksSearchPage]
class TasksSearchRoute extends _i17.PageRouteInfo<void> {
  const TasksSearchRoute({List<_i17.PageRouteInfo>? children})
    : super(TasksSearchRoute.name, initialChildren: children);

  static const String name = 'TasksSearchRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i15.TasksSearchPage();
    },
  );
}

/// generated route for
/// [_i16.TasksShellRoute]
class TasksShellRoute extends _i17.PageRouteInfo<void> {
  const TasksShellRoute({List<_i17.PageRouteInfo>? children})
    : super(TasksShellRoute.name, initialChildren: children);

  static const String name = 'TasksShellRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i16.TasksShellRoute();
    },
  );
}
