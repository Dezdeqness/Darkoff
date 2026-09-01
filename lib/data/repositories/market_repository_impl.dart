import 'package:darkoff/data/datasources/market/market_data_source.dart';
import 'package:market_contract/market_contract.dart';
import 'package:result_dart/result_dart.dart';

class MarketRepositoryImpl implements MarketRepository {
  const MarketRepositoryImpl({required MarketDataSource dataSource})
    : _dataSource = dataSource;

  final MarketDataSource _dataSource;

  @override
  Future<Result<List<MarketItemEntity>>> getMarketOverview() => _dataSource.getMarketOverview();
}
