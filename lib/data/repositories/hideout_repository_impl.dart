import 'package:darkoff/data/datasources/hideout/hideout_data_source.dart';
import 'package:hideout_contract/hideout_contract.dart';
import 'package:result_dart/result_dart.dart';

class HideoutRepositoryImpl implements HideoutRepository {
  const HideoutRepositoryImpl({required HideoutDataSource dataSource})
    : _dataSource = dataSource;

  final HideoutDataSource _dataSource;

  @override
  Future<Result<List<HideoutStationEntity>>> getStations() => _dataSource.getStations();
}
