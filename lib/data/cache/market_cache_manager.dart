import 'package:darkoff/data/cache/base_cache_manager.dart';
import 'package:darkoff/data/local/dao/market_snapshot_dao.dart';
import 'package:market_contract/market_contract.dart';

class MarketCacheManager extends BaseCacheManager<List<MarketItemEntity>> {
  MarketCacheManager({
    required MarketRepository repository,
    required MarketSnapshotDao dao,
  })  : _repository = repository,
        _dao = dao;

  final MarketRepository _repository;
  final MarketSnapshotDao _dao;

  @override
  Future<List<MarketItemEntity>?> readCache() async {
    final items = await _dao.getAll();
    return items.isEmpty ? null : items;
  }

  @override
  Future<void> performUpdate() async {
    final current = await _dao.getAll();
    final result = await _repository.getMarketOverview();
    await result.fold(
      (remote) async {
        final changes = diff(
          current: current,
          incoming: remote,
          key: (item) => item.id,
        );
        await _dao.upsertAll(remote);
        await _dao.deleteByIds(changes.toRemove.map((e) => e.id).toList());
        emitData(remote);
      },
      (error) async {
        if (current.isEmpty) emitError(error);
      },
    );
  }
}
