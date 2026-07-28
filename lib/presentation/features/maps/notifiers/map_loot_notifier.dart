import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/boss_loot_item_entity.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:darkoff/presentation/features/maps/model/map_loot_ui_model.dart';
import 'package:darkoff/presentation/features/maps/notifiers/maps_notifier.dart';
import 'package:darkoff/presentation/features/maps/state/maps_state.dart';
import 'package:darkoff/service_locator/maps_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_loot_notifier.g.dart';

@riverpod
Future<List<MapLootUiModel>> mapLoot(Ref ref, String mapId) async {
  final state = ref.watch(mapsProvider);
  if (state is! MapsLoaded) return const [];

  final map = state.maps.where((m) => m.id == mapId).firstOrNull;
  if (map == null || map.lootItemIds.isEmpty) return const [];

  final repository = getIt<ItemsRepository>();
  final result = await repository.getBossLoot(map.lootItemIds);

  return result.fold((items) => _top(items), (error) => throw error);
}

const _maxItems = 6;

List<MapLootUiModel> _top(List<BossLootItemEntity> items) {
  final sorted = [...items]..sort((a, b) => _value(b).compareTo(_value(a)));

  return [
    for (final item in sorted.take(_maxItems))
      MapLootUiModel(
        id: item.id,
        name: item.name,
        iconUrl: item.iconLink,
        priceLabel: '${formatPrice(_value(item))} ₽',
      ),
  ];
}

int _value(BossLootItemEntity item) {
  final flea = item.fleaPrice ?? 0;
  final trader = item.traderPrice ?? 0;
  return flea > trader ? flea : trader;
}
