import 'package:darkoff/data/cache/base_cache_manager.dart';
import 'package:darkoff/data/local/dao/flea_cache_dao.dart';
import 'package:flea_contract/flea_contract.dart';

class FleaCacheManager extends BaseCacheManager<List<FleaItemEntity>> {
  FleaCacheManager({
    required FleaRepository repository,
    required FleaCacheDao dao,
  })  : _repository = repository,
        _dao = dao;

  final FleaRepository _repository;
  final FleaCacheDao _dao;

  @override
  Future<List<FleaItemEntity>?> readCache() async {
    final items = await _dao.getAll();
    return items.isEmpty ? null : items;
  }

  @override
  Future<void> performUpdate() async {
    final current = await _dao.getAll();
    final result = await _repository.getFleaItems();
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
