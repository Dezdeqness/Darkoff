import 'package:darkoff/data/local/dao/hideout_progress_dao.dart';
import 'package:darkoff/domain/entities/hideout_progress_entity.dart';
import 'package:darkoff/domain/repositories/hideout_progress_repository.dart';

class HideoutProgressRepositoryImpl implements HideoutProgressRepository {
  HideoutProgressRepositoryImpl({required HideoutProgressDao dao}) : _dao = dao;

  final HideoutProgressDao _dao;

  @override
  Future<HideoutProgressEntity> getProgress() => _dao.getProgress();

  @override
  Future<void> setOwnedCount({
    required String stationId,
    required int level,
    required String itemId,
    required int count,
  }) => _dao.setOwnedCount(
    stationId: stationId,
    level: level,
    itemId: itemId,
    count: count,
  );

  @override
  Future<void> setLevelBuilt({
    required String stationId,
    required int level,
    required bool built,
  }) => _dao.setLevelBuilt(stationId: stationId, level: level, built: built);

  @override
  Future<void> setTracked({required String stationId, required bool tracked}) =>
      _dao.setTracked(stationId: stationId, tracked: tracked);
}
