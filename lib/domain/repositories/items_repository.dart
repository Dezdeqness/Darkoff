import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class ItemsRepository {
  Future<Result<List<ItemDetailEntity>>> getItems();

  Future<Result<List<ItemEntity>>> getLocalItems({
    List<String> categoryNames = const [],
  });

  Future<Result<ItemDetailEntity>> getLocalItemDetail(String id);

  Future<Result<ItemDetailEntity>> getItemDetail(String id);

  Future<Result<List<ItemEntity>>> searchItems({String query = ''});
}
