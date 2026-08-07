// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i29;
import 'package:collection/collection.dart' as _i31;
import 'package:darkoff/core/navigation/shells/tarkov_shell_page.dart' as _i22;
import 'package:darkoff/presentation/features/ammo/ammo_page.dart' as _i1;
import 'package:darkoff/presentation/features/barters/barters_page.dart' as _i2;
import 'package:darkoff/presentation/features/boss_detail/boss_detail_page.dart'
    as _i3;
import 'package:darkoff/presentation/features/bosses/bosses_page.dart' as _i4;
import 'package:darkoff/presentation/features/crafts/crafts_page.dart' as _i5;
import 'package:darkoff/presentation/features/flea_market/flea_market_page.dart'
    as _i6;
import 'package:darkoff/presentation/features/hideout/hideout_page.dart' as _i8;
import 'package:darkoff/presentation/features/hideout_detail/hideout_detail_page.dart'
    as _i7;
import 'package:darkoff/presentation/features/home/home_page.dart' as _i9;
import 'package:darkoff/presentation/features/item_detail/item_detail_page.dart'
    as _i10;
import 'package:darkoff/presentation/features/items/items_page.dart' as _i11;
import 'package:darkoff/presentation/features/items/items_search_page.dart'
    as _i12;
import 'package:darkoff/presentation/features/items/items_shell_route.dart'
    as _i13;
import 'package:darkoff/presentation/features/keys/keys_page.dart' as _i14;
import 'package:darkoff/presentation/features/maps/map_detail_page.dart'
    as _i15;
import 'package:darkoff/presentation/features/maps/maps_page.dart' as _i16;
import 'package:darkoff/presentation/features/more/more_page.dart' as _i17;
import 'package:darkoff/presentation/features/more/more_shell_route.dart'
    as _i18;
import 'package:darkoff/presentation/features/settings/settings_page.dart'
    as _i19;
import 'package:darkoff/presentation/features/shopping_list/shopping_list_page.dart'
    as _i20;
import 'package:darkoff/presentation/features/splash/splash_page.dart' as _i21;
import 'package:darkoff/presentation/features/task_detail/task_detail_page.dart'
    as _i23;
import 'package:darkoff/presentation/features/tasks/tasks_page.dart' as _i24;
import 'package:darkoff/presentation/features/tasks/tasks_search_page.dart'
    as _i25;
import 'package:darkoff/presentation/features/tasks/tasks_shell_route.dart'
    as _i26;
import 'package:darkoff/presentation/features/traders/traders_page.dart'
    as _i28;
import 'package:darkoff/presentation/features/traders_detail/traders_detail_page.dart'
    as _i27;
import 'package:flutter/material.dart' as _i30;

/// generated route for
/// [_i1.AmmoPage]
class AmmoRoute extends _i29.PageRouteInfo<void> {
  const AmmoRoute({List<_i29.PageRouteInfo>? children})
    : super(AmmoRoute.name, initialChildren: children);

  static const String name = 'AmmoRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i1.AmmoPage();
    },
  );
}

/// generated route for
/// [_i2.BartersPage]
class BartersRoute extends _i29.PageRouteInfo<void> {
  const BartersRoute({List<_i29.PageRouteInfo>? children})
    : super(BartersRoute.name, initialChildren: children);

  static const String name = 'BartersRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i2.BartersPage();
    },
  );
}

/// generated route for
/// [_i3.BossDetailPage]
class BossDetailRoute extends _i29.PageRouteInfo<BossDetailRouteArgs> {
  BossDetailRoute({
    _i30.Key? key,
    required String bossId,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         BossDetailRoute.name,
         args: BossDetailRouteArgs(key: key, bossId: bossId),
         rawPathParams: {'bossId': bossId},
         initialChildren: children,
       );

  static const String name = 'BossDetailRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<BossDetailRouteArgs>(
        orElse: () =>
            BossDetailRouteArgs(bossId: pathParams.getString('bossId')),
      );
      return _i3.BossDetailPage(key: args.key, bossId: args.bossId);
    },
  );
}

class BossDetailRouteArgs {
  const BossDetailRouteArgs({this.key, required this.bossId});

  final _i30.Key? key;

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
/// [_i4.BossesPage]
class BossesRoute extends _i29.PageRouteInfo<void> {
  const BossesRoute({List<_i29.PageRouteInfo>? children})
    : super(BossesRoute.name, initialChildren: children);

  static const String name = 'BossesRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i4.BossesPage();
    },
  );
}

/// generated route for
/// [_i5.CraftsPage]
class CraftsRoute extends _i29.PageRouteInfo<void> {
  const CraftsRoute({List<_i29.PageRouteInfo>? children})
    : super(CraftsRoute.name, initialChildren: children);

  static const String name = 'CraftsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i5.CraftsPage();
    },
  );
}

/// generated route for
/// [_i6.FleaMarketPage]
class FleaMarketRoute extends _i29.PageRouteInfo<void> {
  const FleaMarketRoute({List<_i29.PageRouteInfo>? children})
    : super(FleaMarketRoute.name, initialChildren: children);

  static const String name = 'FleaMarketRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i6.FleaMarketPage();
    },
  );
}

/// generated route for
/// [_i7.HideoutDetailPage]
class HideoutDetailRoute extends _i29.PageRouteInfo<HideoutDetailRouteArgs> {
  HideoutDetailRoute({
    _i30.Key? key,
    required String stationId,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         HideoutDetailRoute.name,
         args: HideoutDetailRouteArgs(key: key, stationId: stationId),
         rawPathParams: {'detailId': stationId},
         initialChildren: children,
       );

  static const String name = 'HideoutDetailRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<HideoutDetailRouteArgs>(
        orElse: () =>
            HideoutDetailRouteArgs(stationId: pathParams.getString('detailId')),
      );
      return _i7.HideoutDetailPage(key: args.key, stationId: args.stationId);
    },
  );
}

class HideoutDetailRouteArgs {
  const HideoutDetailRouteArgs({this.key, required this.stationId});

  final _i30.Key? key;

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
/// [_i8.HideoutPage]
class HideoutRoute extends _i29.PageRouteInfo<void> {
  const HideoutRoute({List<_i29.PageRouteInfo>? children})
    : super(HideoutRoute.name, initialChildren: children);

  static const String name = 'HideoutRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i8.HideoutPage();
    },
  );
}

/// generated route for
/// [_i9.HomePage]
class HomeRoute extends _i29.PageRouteInfo<void> {
  const HomeRoute({List<_i29.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i9.HomePage();
    },
  );
}

/// generated route for
/// [_i10.ItemDetailPage]
class ItemDetailRoute extends _i29.PageRouteInfo<ItemDetailRouteArgs> {
  ItemDetailRoute({
    _i30.Key? key,
    required String itemId,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ItemDetailRoute.name,
         args: ItemDetailRouteArgs(key: key, itemId: itemId),
         rawPathParams: {'id': itemId},
         initialChildren: children,
       );

  static const String name = 'ItemDetailRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<ItemDetailRouteArgs>(
        orElse: () => ItemDetailRouteArgs(itemId: pathParams.getString('id')),
      );
      return _i10.ItemDetailPage(key: args.key, itemId: args.itemId);
    },
  );
}

class ItemDetailRouteArgs {
  const ItemDetailRouteArgs({this.key, required this.itemId});

  final _i30.Key? key;

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
/// [_i11.ItemsPage]
class ItemsRoute extends _i29.PageRouteInfo<ItemsRouteArgs> {
  ItemsRoute({
    _i30.Key? key,
    List<String> categoryNames = const [],
    List<_i29.PageRouteInfo>? children,
  }) : super(
         ItemsRoute.name,
         args: ItemsRouteArgs(key: key, categoryNames: categoryNames),
         initialChildren: children,
       );

  static const String name = 'ItemsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ItemsRouteArgs>(
        orElse: () => const ItemsRouteArgs(),
      );
      return _i11.ItemsPage(key: args.key, categoryNames: args.categoryNames);
    },
  );
}

class ItemsRouteArgs {
  const ItemsRouteArgs({this.key, this.categoryNames = const []});

  final _i30.Key? key;

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
        const _i31.ListEquality<String>().equals(
          categoryNames,
          other.categoryNames,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^ const _i31.ListEquality<String>().hash(categoryNames);
}

/// generated route for
/// [_i12.ItemsSearchPage]
class ItemsSearchRoute extends _i29.PageRouteInfo<void> {
  const ItemsSearchRoute({List<_i29.PageRouteInfo>? children})
    : super(ItemsSearchRoute.name, initialChildren: children);

  static const String name = 'ItemsSearchRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i12.ItemsSearchPage();
    },
  );
}

/// generated route for
/// [_i13.ItemsShellRoute]
class ItemsShellRoute extends _i29.PageRouteInfo<void> {
  const ItemsShellRoute({List<_i29.PageRouteInfo>? children})
    : super(ItemsShellRoute.name, initialChildren: children);

  static const String name = 'ItemsShellRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i13.ItemsShellRoute();
    },
  );
}

/// generated route for
/// [_i14.KeysPage]
class KeysRoute extends _i29.PageRouteInfo<void> {
  const KeysRoute({List<_i29.PageRouteInfo>? children})
    : super(KeysRoute.name, initialChildren: children);

  static const String name = 'KeysRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i14.KeysPage();
    },
  );
}

/// generated route for
/// [_i15.MapDetailPage]
class MapDetailRoute extends _i29.PageRouteInfo<MapDetailRouteArgs> {
  MapDetailRoute({
    _i30.Key? key,
    required String mapId,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         MapDetailRoute.name,
         args: MapDetailRouteArgs(key: key, mapId: mapId),
         rawPathParams: {'mapId': mapId},
         initialChildren: children,
       );

  static const String name = 'MapDetailRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MapDetailRouteArgs>(
        orElse: () => MapDetailRouteArgs(mapId: pathParams.getString('mapId')),
      );
      return _i15.MapDetailPage(key: args.key, mapId: args.mapId);
    },
  );
}

class MapDetailRouteArgs {
  const MapDetailRouteArgs({this.key, required this.mapId});

  final _i30.Key? key;

  final String mapId;

  @override
  String toString() {
    return 'MapDetailRouteArgs{key: $key, mapId: $mapId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MapDetailRouteArgs) return false;
    return key == other.key && mapId == other.mapId;
  }

  @override
  int get hashCode => key.hashCode ^ mapId.hashCode;
}

/// generated route for
/// [_i16.MapsPage]
class MapsRoute extends _i29.PageRouteInfo<void> {
  const MapsRoute({List<_i29.PageRouteInfo>? children})
    : super(MapsRoute.name, initialChildren: children);

  static const String name = 'MapsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i16.MapsPage();
    },
  );
}

/// generated route for
/// [_i17.MorePage]
class MoreRoute extends _i29.PageRouteInfo<void> {
  const MoreRoute({List<_i29.PageRouteInfo>? children})
    : super(MoreRoute.name, initialChildren: children);

  static const String name = 'MoreRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i17.MorePage();
    },
  );
}

/// generated route for
/// [_i18.MoreShellRoute]
class MoreShellRoute extends _i29.PageRouteInfo<void> {
  const MoreShellRoute({List<_i29.PageRouteInfo>? children})
    : super(MoreShellRoute.name, initialChildren: children);

  static const String name = 'MoreShellRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i18.MoreShellRoute();
    },
  );
}

/// generated route for
/// [_i19.SettingsPage]
class SettingsRoute extends _i29.PageRouteInfo<void> {
  const SettingsRoute({List<_i29.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i19.SettingsPage();
    },
  );
}

/// generated route for
/// [_i20.ShoppingListPage]
class ShoppingListRoute extends _i29.PageRouteInfo<void> {
  const ShoppingListRoute({List<_i29.PageRouteInfo>? children})
    : super(ShoppingListRoute.name, initialChildren: children);

  static const String name = 'ShoppingListRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i20.ShoppingListPage();
    },
  );
}

/// generated route for
/// [_i21.SplashPage]
class SplashRoute extends _i29.PageRouteInfo<void> {
  const SplashRoute({List<_i29.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i21.SplashPage();
    },
  );
}

/// generated route for
/// [_i22.TarkovShellScreen]
class TarkovShellRoute extends _i29.PageRouteInfo<void> {
  const TarkovShellRoute({List<_i29.PageRouteInfo>? children})
    : super(TarkovShellRoute.name, initialChildren: children);

  static const String name = 'TarkovShellRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i22.TarkovShellScreen();
    },
  );
}

/// generated route for
/// [_i23.TaskDetailPage]
class TaskDetailRoute extends _i29.PageRouteInfo<TaskDetailRouteArgs> {
  TaskDetailRoute({
    _i30.Key? key,
    required String taskId,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         TaskDetailRoute.name,
         args: TaskDetailRouteArgs(key: key, taskId: taskId),
         rawPathParams: {'taskId': taskId},
         initialChildren: children,
       );

  static const String name = 'TaskDetailRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TaskDetailRouteArgs>(
        orElse: () =>
            TaskDetailRouteArgs(taskId: pathParams.getString('taskId')),
      );
      return _i23.TaskDetailPage(key: args.key, taskId: args.taskId);
    },
  );
}

class TaskDetailRouteArgs {
  const TaskDetailRouteArgs({this.key, required this.taskId});

  final _i30.Key? key;

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
/// [_i24.TasksPage]
class TasksRoute extends _i29.PageRouteInfo<void> {
  const TasksRoute({List<_i29.PageRouteInfo>? children})
    : super(TasksRoute.name, initialChildren: children);

  static const String name = 'TasksRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i24.TasksPage();
    },
  );
}

/// generated route for
/// [_i25.TasksSearchPage]
class TasksSearchRoute extends _i29.PageRouteInfo<void> {
  const TasksSearchRoute({List<_i29.PageRouteInfo>? children})
    : super(TasksSearchRoute.name, initialChildren: children);

  static const String name = 'TasksSearchRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i25.TasksSearchPage();
    },
  );
}

/// generated route for
/// [_i26.TasksShellRoute]
class TasksShellRoute extends _i29.PageRouteInfo<void> {
  const TasksShellRoute({List<_i29.PageRouteInfo>? children})
    : super(TasksShellRoute.name, initialChildren: children);

  static const String name = 'TasksShellRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i26.TasksShellRoute();
    },
  );
}

/// generated route for
/// [_i27.TradersDetailPage]
class TradersDetailRoute extends _i29.PageRouteInfo<TradersDetailRouteArgs> {
  TradersDetailRoute({
    _i30.Key? key,
    required String traderId,
    List<_i29.PageRouteInfo>? children,
  }) : super(
         TradersDetailRoute.name,
         args: TradersDetailRouteArgs(key: key, traderId: traderId),
         rawPathParams: {'traderId': traderId},
         initialChildren: children,
       );

  static const String name = 'TradersDetailRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<TradersDetailRouteArgs>(
        orElse: () =>
            TradersDetailRouteArgs(traderId: pathParams.getString('traderId')),
      );
      return _i27.TradersDetailPage(key: args.key, traderId: args.traderId);
    },
  );
}

class TradersDetailRouteArgs {
  const TradersDetailRouteArgs({this.key, required this.traderId});

  final _i30.Key? key;

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
/// [_i28.TradersPage]
class TradersRoute extends _i29.PageRouteInfo<void> {
  const TradersRoute({List<_i29.PageRouteInfo>? children})
    : super(TradersRoute.name, initialChildren: children);

  static const String name = 'TradersRoute';

  static _i29.PageInfo page = _i29.PageInfo(
    name,
    builder: (data) {
      return const _i28.TradersPage();
    },
  );
}
