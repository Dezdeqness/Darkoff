import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class ItemsRepository {
  Future<Result<List<ItemDetailEntity>>> getItems({
    int limit = 50,
    int offset = 0,
  });

  Future<Result<List<ItemEntity>>> getLocalItems({
    List<String> categoryNames = const [],
  });

  Future<Result<ItemDetailEntity>> getLocalItemDetail(String id);

  Future<Result<ItemDetailEntity>> getItemDetail(String id);
}
