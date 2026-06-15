// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i12;
import 'package:collection/collection.dart' as _i14;
import 'package:darkoff/core/navigation/shells/tarkov_shell_page.dart' as _i7;
import 'package:darkoff/presentation/features/categories/categories_page.dart'
    as _i1;
import 'package:darkoff/presentation/features/item_detail/item_detail_page.dart'
    as _i2;
import 'package:darkoff/presentation/features/items/items_page.dart' as _i3;
import 'package:darkoff/presentation/features/items/items_search_page.dart'
    as _i4;
import 'package:darkoff/presentation/features/items/items_shell_route.dart'
    as _i5;
import 'package:darkoff/presentation/features/splash/splash_page.dart' as _i6;
import 'package:darkoff/presentation/features/tasks/task_detail_page.dart'
    as _i8;
import 'package:darkoff/presentation/features/tasks/tasks_page.dart' as _i9;
import 'package:darkoff/presentation/features/tasks/tasks_search_page.dart'
    as _i10;
import 'package:darkoff/presentation/features/tasks/tasks_shell_route.dart'
    as _i11;
import 'package:flutter/material.dart' as _i13;

/// generated route for
/// [_i1.CategoriesPage]
class CategoriesRoute extends _i12.PageRouteInfo<void> {
  const CategoriesRoute({List<_i12.PageRouteInfo>? children})
    : super(CategoriesRoute.name, initialChildren: children);

  static const String name = 'CategoriesRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i1.CategoriesPage();
    },
  );
}

/// generated route for
/// [_i2.ItemDetailPage]
class ItemDetailRoute extends _i12.PageRouteInfo<ItemDetailRouteArgs> {
  ItemDetailRoute({
    _i13.Key? key,
    required String itemId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         ItemDetailRoute.name,
         args: ItemDetailRouteArgs(key: key, itemId: itemId),
         rawPathParams: {'id': itemId},
         initialChildren: children,
       );

  static const String name = 'ItemDetailRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ItemDetailRouteArgs>(
        orElse: () => ItemDetailRouteArgs(itemId: pathParams.getString('id')),
      );
      return _i2.ItemDetailPage(key: args.key, itemId: args.itemId);
    },
  );
}

class ItemDetailRouteArgs {
  const ItemDetailRouteArgs({this.key, required this.itemId});

  final _i13.Key? key;

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
/// [_i3.ItemsPage]
class ItemsRoute extends _i12.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i13.Key? key,
    List<String> categoryNames = const [],
    List<_i12.PageRouteInfo>? children,
  }) : super(
         ItemsRoute.name,
         args: ItemsRouteArgs(key: key, categoryNames: categoryNames),
         initialChildren: children,
       );

  static const String name = 'ItemsRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>(
        orElse: () => const ItemsRouteArgs(),
      );
      return _i3.ItemsPage(key: args.key, categoryNames: args.categoryNames);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, this.categoryNames = const []});

  final _i13.Key? key;

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
        const _i14.ListEquality<String>().equals(
          categoryNames,
          other.categoryNames,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i14.ListEquality<String>().hash(categoryNames);
}

/// generated route for
/// [_i4.ItemsSearchPage]
class ItemsSearchRoute extends _i12.PageRouteInfo<void> {
  const ItemsSearchRoute({List<_i12.PageRouteInfo>? children})
    : super(ItemsSearchRoute.name, initialChildren: children);

  static const String name = 'ItemsSearchRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i4.ItemsSearchPage();
    },
  );
}

/// generated route for
/// [_i5.ItemsShellRoute]
class ItemsShellRoute extends _i12.PageRouteInfo<void> {
  const ItemsShellRoute({List<_i12.PageRouteInfo>? children})
    : super(ItemsShellRoute.name, initialChildren: children);

  static const String name = 'ItemsShellRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i5.ItemsShellRoute();
    },
  );
}

/// generated route for
/// [_i6.SplashPage]
class SplashRoute extends _i12.PageRouteInfo<void> {
  const SplashRoute({List<_i12.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i6.SplashPage();
    },
  );
}

/// generated route for
/// [_i7.TarkovShellScreen]
class TarkovShellRoute extends _i12.PageRouteInfo<void> {
  const TarkovShellRoute({List<_i12.PageRouteInfo>? children})
    : super(TarkovShellRoute.name, initialChildren: children);

  static const String name = 'TarkovShellRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i7.TarkovShellScreen();
    },
  );
}

/// generated route for
/// [_i8.TaskDetailPage]
class TaskDetailRoute extends _i12.PageRouteInfo<TaskDetailRouteArgs> {
  TaskDetailRoute({
    _i13.Key? key,
    required String taskId,
    List<_i12.PageRouteInfo>? children,
  }) : super(
         TaskDetailRoute.name,
         args: TaskDetailRouteArgs(key: key, taskId: taskId),
         rawPathParams: {'taskId': taskId},
         initialChildren: children,
       );

  static const String name = 'TaskDetailRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TaskDetailRouteArgs>(
        orElse: () =>
            TaskDetailRouteArgs(taskId: pathParams.getString('taskId')),
      );
      return _i8.TaskDetailPage(key: args.key, taskId: args.taskId);
    },
  );
}

class TaskDetailRouteArgs {
  const TaskDetailRouteArgs({this.key, required this.taskId});

  final _i13.Key? key;

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
/// [_i9.TasksPage]
class TasksRoute extends _i12.PageRouteInfo<void> {
  const TasksRoute({List<_i12.PageRouteInfo>? children})
    : super(TasksRoute.name, initialChildren: children);

  static const String name = 'TasksRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i9.TasksPage();
    },
  );
}

/// generated route for
/// [_i10.TasksSearchPage]
class TasksSearchRoute extends _i12.PageRouteInfo<void> {
  const TasksSearchRoute({List<_i12.PageRouteInfo>? children})
    : super(TasksSearchRoute.name, initialChildren: children);

  static const String name = 'TasksSearchRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i10.TasksSearchPage();
    },
  );
}

/// generated route for
/// [_i11.TasksShellRoute]
class TasksShellRoute extends _i12.PageRouteInfo<void> {
  const TasksShellRoute({List<_i12.PageRouteInfo>? children})
    : super(TasksShellRoute.name, initialChildren: children);

  static const String name = 'TasksShellRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i11.TasksShellRoute();
    },
  );
}
