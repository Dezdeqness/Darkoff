import 'package:darkoff/data/datasources/items/items_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  const ItemsRepositoryImpl({
    required ItemsDataSource dataSource,
    required ItemsDao dao,
  }) : _dataSource = dataSource,
       _dao = dao;

  final ItemsDataSource _dataSource;
  final ItemsDao _dao;

  @override
  Future<Result<List<ItemDetailEntity>>> getItems() => _dataSource.getItems();

  @override
  Future<Result<ItemDetailEntity>> getItemDetail(String id) =>
      _dataSource.getItemDetail(id);

  @override
  Future<Result<List<ItemEntity>>> getLocalItems({
    List<String> categoryNames = const [],
  }) async {
    try {
      return successOf(await _dao.getItemsByCategoryNames(categoryNames));
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  @override
  Future<Result<ItemDetailEntity>> getLocalItemDetail(String id) async {
    try {
      final detail = await _dao.getItemDetailById(id);
      if (detail == null) {
        return failureOf(Exception('Item not found in local database'));
      }
      return successOf(detail);
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<ItemEntity>>> searchItems({String query = ''}) async {
    try {
      return successOf(await _dao.searchItems(query: query));
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
