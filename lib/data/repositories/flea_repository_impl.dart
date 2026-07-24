import 'package:darkoff/data/datasources/flea/flea_data_source.dart';
import 'package:darkoff/domain/entities/flea_item_entity.dart';
import 'package:darkoff/domain/repositories/flea_repository.dart';
import 'package:result_dart/result_dart.dart';

class FleaRepositoryImpl implements FleaRepository {
  const FleaRepositoryImpl({required FleaDataSource dataSource})
    : _dataSource = dataSource;

  final FleaDataSource _dataSource;

  @override
  Future<Result<List<FleaItemEntity>>> getFleaItems() => _dataSource.getFleaItems();
}
