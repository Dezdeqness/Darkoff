import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:flea_contract/flea_contract.dart';
import 'package:result_dart/result_dart.dart';

class FleaDataSource {
  FleaDataSource({required ItemsDao dao}) : _dao = dao;

  final ItemsDao _dao;

  Future<Result<List<FleaItemEntity>>> getFleaItems() =>
      safeApiCall(_dao.getFleaItems);
}
