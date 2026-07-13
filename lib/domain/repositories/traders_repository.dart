import 'package:darkoff/domain/entities/trader_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class TradersRepository {
  Future<Result<List<TraderEntity>>> getTraders();
}
