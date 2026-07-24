import 'package:darkoff/data/datasources/hideout/hideout_data_source.dart';
import 'package:darkoff/domain/entities/hideout_entity.dart';
import 'package:darkoff/domain/repositories/hideout_repository.dart';
import 'package:result_dart/result_dart.dart';

class HideoutRepositoryImpl implements HideoutRepository {
  const HideoutRepositoryImpl({required HideoutDataSource dataSource})
    : _dataSource = dataSource;

  final HideoutDataSource _dataSource;

  @override
  Future<Result<List<HideoutStationEntity>>> getStations() => _dataSource.getStations();
}
