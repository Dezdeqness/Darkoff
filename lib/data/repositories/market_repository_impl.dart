import 'package:darkoff/data/datasources/market/market_data_source.dart';
import 'package:darkoff/domain/entities/market_item_entity.dart';
import 'package:darkoff/domain/repositories/market_repository.dart';
import 'package:result_dart/result_dart.dart';

class MarketRepositoryImpl implements MarketRepository {
  const MarketRepositoryImpl({required MarketDataSource dataSource})
    : _dataSource = dataSource;

  final MarketDataSource _dataSource;

  @override
  Future<Result<List<MarketItemEntity>>> getMarketOverview() => _dataSource.getMarketOverview();
}
