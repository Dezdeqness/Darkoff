import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class ItemsRepository {
  Future<Result<List<ItemEntity>>> getItems({
    int limit = 50,
    int offset = 0,
    List<Enum$ItemType> types = const [],
  });
}
