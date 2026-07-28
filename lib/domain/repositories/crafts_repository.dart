import 'package:darkoff/domain/entities/craft_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class CraftsRepository {
  Future<Result<List<CraftEntity>>> getCrafts();
}
