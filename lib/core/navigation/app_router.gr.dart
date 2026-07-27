// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i25;
import 'package:collection/collection.dart' as _i27;
import 'package:darkoff/core/navigation/shells/tarkov_shell_page.dart' as _i18;
import 'package:darkoff/presentation/features/ammo/ammo_page.dart' as _i1;
import 'package:darkoff/presentation/features/boss_detail/boss_detail_page.dart'
    as _i2;
import 'package:darkoff/presentation/features/bosses/bosses_page.dart' as _i3;
import 'package:darkoff/presentation/features/categories/categories_page.dart'
    as _i4;
import 'package:darkoff/presentation/features/flea_market/flea_market_page.dart'
    as _i5;
import 'package:darkoff/presentation/features/hideout/hideout_page.dart' as _i7;
import 'package:darkoff/presentation/features/hideout_detail/hideout_detail_page.dart'
    as _i6;
import 'package:darkoff/presentation/features/home/home_page.dart' as _i8;
import 'package:darkoff/presentation/features/item_detail/item_detail_page.dart'
    as _i9;
import 'package:darkoff/presentation/features/items/items_page.dart' as _i10;
import 'package:darkoff/presentation/features/items/items_search_page.dart'
    as _i11;
import 'package:darkoff/presentation/features/items/items_shell_route.dart'
    as _i12;
import 'package:darkoff/presentation/features/keys/keys_page.dart' as _i13;
import 'package:darkoff/presentation/features/more/more_page.dart' as _i14;
import 'package:darkoff/presentation/features/more/more_shell_route.dart'
    as _i15;
import 'package:darkoff/presentation/features/shopping_list/shopping_list_page.dart'
    as _i16;
import 'package:darkoff/presentation/features/splash/splash_page.dart' as _i17;
import 'package:darkoff/presentation/features/task_detail/task_detail_page.dart'
    as _i19;
import 'package:darkoff/presentation/features/tasks/tasks_page.dart' as _i20;
import 'package:darkoff/presentation/features/tasks/tasks_search_page.dart'
    as _i21;
import 'package:darkoff/presentation/features/tasks/tasks_shell_route.dart'
    as _i22;
import 'package:darkoff/presentation/features/traders/traders_page.dart'
    as _i24;
import 'package:darkoff/presentation/features/traders_detail/traders_detail_page.dart'
    as _i23;
import 'package:flutter/material.dart' as _i26;

/// generated route for
/// [_i1.AmmoPage]
class AmmoRoute extends _i25.PageRouteInfo<void> {
  const AmmoRoute({List<_i25.PageRouteInfo>? children})
    : super(AmmoRoute.name, initialChildren: children);

  static const String name = 'AmmoRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i1.AmmoPage();
    },
  );
}

/// generated route for
/// [_i2.BossDetailPage]
class BossDetailRoute extends _i25.PageRouteInfo<BossDetailRouteArgs> {
  BossDetailRoute({
    _i26.Key? key,
    required String bossId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         BossDetailRoute.name,
         args: BossDetailRouteArgs(key: key, bossId: bossId),
         rawPathParams: {'bossId': bossId},
         initialChildren: children,
       );

  static const String name = 'BossDetailRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<BossDetailRouteArgs>(
        orElse: () =>
            BossDetailRouteArgs(bossId: pathParams.getString('bossId')),
      );
      return _i2.BossDetailPage(key: args.key, bossId: args.bossId);
    },
  );
}

class BossDetailRouteArgs {
  const BossDetailRouteArgs({this.key, required this.bossId});

  final _i26.Key? key;

  final String bossId;

  @override
  String toString() {
    return 'BossDetailRouteArgs{key: $key, bossId: $bossId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! BossDetailRouteArgs) return false;
    return key == other.key && bossId == other.bossId;
  }

  @override
  int get hashCode => key.hashCode ^ bossId.hashCode;
}

/// generated route for
/// [_i3.BossesPage]
class BossesRoute extends _i25.PageRouteInfo<void> {
  const BossesRoute({List<_i25.PageRouteInfo>? children})
    : super(BossesRoute.name, initialChildren: children);

  static const String name = 'BossesRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i3.BossesPage();
    },
  );
}

/// generated route for
/// [_i4.CategoriesPage]
class CategoriesRoute extends _i25.PageRouteInfo<void> {
  const CategoriesRoute({List<_i25.PageRouteInfo>? children})
    : super(CategoriesRoute.name, initialChildren: children);

  static const String name = 'CategoriesRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i4.CategoriesPage();
    },
  );
}

/// generated route for
/// [_i5.FleaMarketPage]
class FleaMarketRoute extends _i25.PageRouteInfo<void> {
  const FleaMarketRoute({List<_i25.PageRouteInfo>? children})
    : super(FleaMarketRoute.name, initialChildren: children);

  static const String name = 'FleaMarketRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i5.FleaMarketPage();
    },
  );
}

/// generated route for
/// [_i6.HideoutDetailPage]
class HideoutDetailRoute extends _i25.PageRouteInfo<HideoutDetailRouteArgs> {
  HideoutDetailRoute({
    _i26.Key? key,
    required String stationId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         HideoutDetailRoute.name,
         args: HideoutDetailRouteArgs(key: key, stationId: stationId),
         rawPathParams: {'detailId': stationId},
         initialChildren: children,
       );

  static const String name = 'HideoutDetailRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<HideoutDetailRouteArgs>(
        orElse: () =>
            HideoutDetailRouteArgs(stationId: pathParams.getString('detailId')),
      );
      return _i6.HideoutDetailPage(key: args.key, stationId: args.stationId);
    },
  );
}

class HideoutDetailRouteArgs {
  const HideoutDetailRouteArgs({this.key, required this.stationId});

  final _i26.Key? key;

  final String stationId;

  @override
  String toString() {
    return 'HideoutDetailRouteArgs{key: $key, stationId: $stationId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! HideoutDetailRouteArgs) return false;
    return key == other.key && stationId == other.stationId;
  }

  @override
  int get hashCode => key.hashCode ^ stationId.hashCode;
}

/// generated route for
/// [_i7.HideoutPage]
class HideoutRoute extends _i25.PageRouteInfo<void> {
  const HideoutRoute({List<_i25.PageRouteInfo>? children})
    : super(HideoutRoute.name, initialChildren: children);

  static const String name = 'HideoutRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i7.HideoutPage();
    },
  );
}

/// generated route for
/// [_i8.HomePage]
class HomeRoute extends _i25.PageRouteInfo<void> {
  const HomeRoute({List<_i25.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i8.HomePage();
    },
  );
}

/// generated route for
/// [_i9.ItemDetailPage]
class ItemDetailRoute extends _i25.PageRouteInfo<ItemDetailRouteArgs> {
  ItemDetailRoute({
    _i26.Key? key,
    required String itemId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         ItemDetailRoute.name,
         args: ItemDetailRouteArgs(key: key, itemId: itemId),
         rawPathParams: {'id': itemId},
         initialChildren: children,
       );

  static const String name = 'ItemDetailRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ItemDetailRouteArgs>(
        orElse: () => ItemDetailRouteArgs(itemId: pathParams.getString('id')),
      );
      return _i9.ItemDetailPage(key: args.key, itemId: args.itemId);
    },
  );
}

class ItemDetailRouteArgs {
  const ItemDetailRouteArgs({this.key, required this.itemId});

  final _i26.Key? key;

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
/// [_i10.ItemsPage]
class ItemsRoute extends _i25.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i26.Key? key,
    List<String> categoryNames = const [],
    List<_i25.PageRouteInfo>? children,
  }) : super(
         ItemsRoute.name,
         args: ItemsRouteArgs(key: key, categoryNames: categoryNames),
         initialChildren: children,
       );

  static const String name = 'ItemsRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>(
        orElse: () => const ItemsRouteArgs(),
      );
      return _i10.ItemsPage(key: args.key, categoryNames: args.categoryNames);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, this.categoryNames = const []});

  final _i26.Key? key;

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
        const _i27.ListEquality<String>().equals(
          categoryNames,
          other.categoryNames,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i27.ListEquality<String>().hash(categoryNames);
}

/// generated route for
/// [_i11.ItemsSearchPage]
class ItemsSearchRoute extends _i25.PageRouteInfo<void> {
  const ItemsSearchRoute({List<_i25.PageRouteInfo>? children})
    : super(ItemsSearchRoute.name, initialChildren: children);

  static const String name = 'ItemsSearchRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i11.ItemsSearchPage();
    },
  );
}

/// generated route for
/// [_i12.ItemsShellRoute]
class ItemsShellRoute extends _i25.PageRouteInfo<void> {
  const ItemsShellRoute({List<_i25.PageRouteInfo>? children})
    : super(ItemsShellRoute.name, initialChildren: children);

  static const String name = 'ItemsShellRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i12.ItemsShellRoute();
    },
  );
}

/// generated route for
/// [_i13.KeysPage]
class KeysRoute extends _i25.PageRouteInfo<void> {
  const KeysRoute({List<_i25.PageRouteInfo>? children})
    : super(KeysRoute.name, initialChildren: children);

  static const String name = 'KeysRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i13.KeysPage();
    },
  );
}

/// generated route for
/// [_i14.MorePage]
class MoreRoute extends _i25.PageRouteInfo<void> {
  const MoreRoute({List<_i25.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i14.MorePage();
    },
  );
}

/// generated route for
/// [_i15.MoreShellRoute]
class MoreShellRoute extends _i25.PageRouteInfo<void> {
  const MoreShellRoute({List<_i25.PageRouteInfo>? children})
    : super(MoreShellRoute.name, initialChildren: children);

  static const String name = 'MoreShellRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i15.MoreShellRoute();
    },
  );
}

/// generated route for
/// [_i16.ShoppingListPage]
class ShoppingListRoute extends _i25.PageRouteInfo<void> {
  const ShoppingListRoute({List<_i25.PageRouteInfo>? children})
    : super(ShoppingListRoute.name, initialChildren: children);

  static const String name = 'ShoppingListRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i16.ShoppingListPage();
    },
  );
}

/// generated route for
/// [_i17.SplashPage]
class SplashRoute extends _i25.PageRouteInfo<void> {
  const SplashRoute({List<_i25.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i17.SplashPage();
    },
  );
}

/// generated route for
/// [_i18.TarkovShellScreen]
class TarkovShellRoute extends _i25.PageRouteInfo<void> {
  const TarkovShellRoute({List<_i25.PageRouteInfo>? children})
    : super(TarkovShellRoute.name, initialChildren: children);

  static const String name = 'TarkovShellRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i18.TarkovShellScreen();
    },
  );
}

/// generated route for
/// [_i19.TaskDetailPage]
class TaskDetailRoute extends _i25.PageRouteInfo<TaskDetailRouteArgs> {
  TaskDetailRoute({
    _i26.Key? key,
    required String taskId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         TaskDetailRoute.name,
         args: TaskDetailRouteArgs(key: key, taskId: taskId),
         rawPathParams: {'taskId': taskId},
         initialChildren: children,
       );

  static const String name = 'TaskDetailRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TaskDetailRouteArgs>(
        orElse: () =>
            TaskDetailRouteArgs(taskId: pathParams.getString('taskId')),
      );
      return _i19.TaskDetailPage(key: args.key, taskId: args.taskId);
    },
  );
}

class TaskDetailRouteArgs {
  const TaskDetailRouteArgs({this.key, required this.taskId});

  final _i26.Key? key;

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
/// [_i20.TasksPage]
class TasksRoute extends _i25.PageRouteInfo<void> {
  const TasksRoute({List<_i25.PageRouteInfo>? children})
    : super(TasksRoute.name, initialChildren: children);

  static const String name = 'TasksRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i20.TasksPage();
    },
  );
}

/// generated route for
/// [_i21.TasksSearchPage]
class TasksSearchRoute extends _i25.PageRouteInfo<void> {
  const TasksSearchRoute({List<_i25.PageRouteInfo>? children})
    : super(TasksSearchRoute.name, initialChildren: children);

  static const String name = 'TasksSearchRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i21.TasksSearchPage();
    },
  );
}

/// generated route for
/// [_i22.TasksShellRoute]
class TasksShellRoute extends _i25.PageRouteInfo<void> {
  const TasksShellRoute({List<_i25.PageRouteInfo>? children})
    : super(TasksShellRoute.name, initialChildren: children);

  static const String name = 'TasksShellRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i22.TasksShellRoute();
    },
  );
}

/// generated route for
/// [_i23.TradersDetailPage]
class TradersDetailRoute extends _i25.PageRouteInfo<TradersDetailRouteArgs> {
  TradersDetailRoute({
    _i26.Key? key,
    required String traderId,
    List<_i25.PageRouteInfo>? children,
  }) : super(
         TradersDetailRoute.name,
         args: TradersDetailRouteArgs(key: key, traderId: traderId),
         rawPathParams: {'traderId': traderId},
         initialChildren: children,
       );

  static const String name = 'TradersDetailRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TradersDetailRouteArgs>(
        orElse: () =>
            TradersDetailRouteArgs(traderId: pathParams.getString('traderId')),
      );
      return _i23.TradersDetailPage(key: args.key, traderId: args.traderId);
    },
  );
}

class TradersDetailRouteArgs {
  const TradersDetailRouteArgs({this.key, required this.traderId});

  final _i26.Key? key;

  final String traderId;

  @override
  String toString() {
    return 'TradersDetailRouteArgs{key: $key, traderId: $traderId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! TradersDetailRouteArgs) return false;
    return key == other.key && traderId == other.traderId;
  }

  @override
  int get hashCode => key.hashCode ^ traderId.hashCode;
}

/// generated route for
/// [_i24.TradersPage]
class TradersRoute extends _i25.PageRouteInfo<void> {
  const TradersRoute({List<_i25.PageRouteInfo>? children})
    : super(TradersRoute.name, initialChildren: children);

  static const String name = 'TradersRoute';

  static _i25.PageInfo page = _i25.PageInfo(
    name,
    builder: (data) {
      return const _i24.TradersPage();
    },
  );
}
