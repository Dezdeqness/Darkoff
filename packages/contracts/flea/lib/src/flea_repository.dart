import 'package:flea_contract/src/flea_item_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class FleaRepository {
  Future<Result<List<FleaItemEntity>>> getFleaItems();
}
