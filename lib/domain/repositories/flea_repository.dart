import 'package:darkoff/domain/entities/flea_item_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class FleaRepository {
  /// One-shot network fetch of the flea market items.
  Future<Result<List<FleaItemEntity>>> getFleaItems();
}
