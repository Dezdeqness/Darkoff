import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/item_detail_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/item_detail.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/items.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  const ItemsRepositoryImpl({
    required DarkoffQLService service,
    required ItemDetailMapper detailMapper,
    required ItemsDao dao,
  })  : _service = service,
        _detailMapper = detailMapper,
        _dao = dao;

  final DarkoffQLService _service;
  final ItemDetailMapper _detailMapper;
  final ItemsDao _dao;

  @override
  Future<Result<List<ItemDetailEntity>>> getItems({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final result = await _service.getItems(
        gameMode: Enum$GameMode.pve,
        limit: limit,
        offset: offset,
      );

      if (result.hasException) {
        return failureOf(
          Exception(result.exception.toString()),
        );
      }

      final data = result.data;

      if (data == null) {
        return failureOf(
          Exception('Empty response'),
        );
      }

      final items = Query$DarkoffItems.fromJson(data);

      return successOf(
        items.items
            .whereType<Query$DarkoffItems$items>()
            .map((item) => _detailMapper.fromGraphql(item))
            .toList(),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<ItemEntity>>> getLocalItems({
    List<String> categoryNames = const [],
  }) async {
    try {
      final items = await _dao.getItemsByCategoryNames(categoryNames);
      return successOf(items);
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
  Future<Result<ItemDetailEntity>> getItemDetail(String id) async {
    try {
      final result = await _service.getItemDetail(id: id);

      if (result.hasException) {
        return failureOf(
          Exception(result.exception.toString()),
        );
      }

      final data = result.data;

      if (data == null) {
        return failureOf(
          Exception('Empty response'),
        );
      }

      final parsed = Query$DarkoffItemDetail.fromJson(data);
      final item = parsed.item;

      if (item == null) {
        return failureOf(
          Exception('Item not found'),
        );
      }

      return successOf(_detailMapper.fromDetailQuery(item));
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<ItemEntity>>> searchItems({String query = ''}) async {
    try {
      final items = await _dao.searchItems(query: query);
      return successOf(items);
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
