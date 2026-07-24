import 'package:darkoff/data/datasources/traders/traders_data_source.dart';
import 'package:darkoff/domain/entities/trader_entity.dart';
import 'package:darkoff/domain/repositories/traders_repository.dart';
import 'package:result_dart/result_dart.dart';

class TradersRepositoryImpl implements TradersRepository {
  const TradersRepositoryImpl({required TradersDataSource dataSource})
    : _dataSource = dataSource;

  final TradersDataSource _dataSource;

  @override
  Future<Result<List<TraderEntity>>> getTraders() => _dataSource.getTraders();
}
