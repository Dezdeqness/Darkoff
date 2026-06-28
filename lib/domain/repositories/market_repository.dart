import 'package:darkoff/domain/entities/market_item_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class MarketRepository {
  Future<Result<List<MarketItemEntity>>> getMarketOverview();
}
