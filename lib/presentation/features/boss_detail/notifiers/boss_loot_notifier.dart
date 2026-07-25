import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/boss_loot_item_entity.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:darkoff/presentation/features/boss_detail/model/boss_loot_ui_model.dart';
import 'package:darkoff/presentation/features/bosses/notifiers/bosses_notifier.dart';
import 'package:darkoff/presentation/features/bosses/state/bosses_state.dart';
import 'package:darkoff/service_locator/boss_service_locator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'boss_loot_notifier.g.dart';

@riverpod
Future<List<BossLootUiModel>> bossLoot(Ref ref, String bossId) async {
  final bossesState = ref.watch(bossesProvider);
  if (bossesState is! BossesLoaded) return const [];

  final boss = bossesState.bosses.where((b) => b.id == bossId).firstOrNull;
  if (boss == null || boss.loot.isEmpty) return const [];

  final ids = [for (final l in boss.loot) l.itemId];

  final repository = getIt<ItemsRepository>();
  final result = await repository.getBossLoot(ids);

  return result.fold(
    (items) => _toUiModels(items),
    (error) => throw error,
  );
}

List<BossLootUiModel> _toUiModels(List<BossLootItemEntity> items) {
  final sorted = [...items]
    ..sort((a, b) => _value(b).compareTo(_value(a)));

  return [
    for (final item in sorted)
      BossLootUiModel(
        id: item.id,
        name: item.name,
        iconUrl: item.iconLink,
        fleaPrice: item.fleaPrice != null
            ? '${formatPrice(item.fleaPrice!)} ₽'
            : null,
        traderPrice: item.traderPrice != null
            ? '${formatPrice(item.traderPrice!)} ₽'
            : null,
      ),
  ];
}

int _value(BossLootItemEntity item) {
  final flea = item.fleaPrice ?? 0;
  final trader = item.traderPrice ?? 0;
  return flea > trader ? flea : trader;
}
