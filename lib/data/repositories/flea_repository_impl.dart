import 'package:darkoff/data/datasources/flea/flea_data_source.dart';
import 'package:flea_contract/flea_contract.dart';
import 'package:result_dart/result_dart.dart';

class FleaRepositoryImpl implements FleaRepository {
  const FleaRepositoryImpl({required FleaDataSource dataSource})
    : _dataSource = dataSource;

  final FleaDataSource _dataSource;

  @override
  Future<Result<List<FleaItemEntity>>> getFleaItems() => _dataSource.getFleaItems();
}
