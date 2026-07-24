import 'package:darkoff/data/datasources/barters/barters_data_source.dart';
import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:darkoff/domain/repositories/barters_repository.dart';
import 'package:result_dart/result_dart.dart';

class BartersRepositoryImpl implements BartersRepository {
  const BartersRepositoryImpl({required BartersDataSource dataSource})
    : _dataSource = dataSource;

  final BartersDataSource _dataSource;

  @override
  Future<Result<List<BarterEntity>>> getBarters() => _dataSource.getBarters();
}
