import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class BartersRepository {
  Future<Result<List<BarterEntity>>> getBarters();
}
