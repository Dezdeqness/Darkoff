import 'package:darkoff/data/datasources/maps/maps_data_source.dart';
import 'package:darkoff/domain/entities/map_entity.dart';
import 'package:darkoff/domain/repositories/maps_repository.dart';
import 'package:result_dart/result_dart.dart';

class MapsRepositoryImpl implements MapsRepository {
  const MapsRepositoryImpl({required MapsDataSource dataSource})
    : _dataSource = dataSource;

  final MapsDataSource _dataSource;

  @override
  Future<Result<List<MapEntity>>> getMaps() => _dataSource.getMaps();
}
