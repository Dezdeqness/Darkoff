import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/domain/entities/ammo_entity.dart';
import 'package:result_dart/result_dart.dart';

class AmmoDataSource {
  AmmoDataSource({required ItemsDao dao}) : _dao = dao;

  final ItemsDao _dao;

  Future<Result<List<AmmoEntity>>> getAmmo() => safeApiCall(_dao.getAmmo);
}
