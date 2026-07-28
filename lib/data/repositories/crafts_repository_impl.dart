import 'package:darkoff/data/datasources/crafts/crafts_data_source.dart';
import 'package:darkoff/domain/entities/craft_entity.dart';
import 'package:darkoff/domain/repositories/crafts_repository.dart';
import 'package:result_dart/result_dart.dart';

class CraftsRepositoryImpl implements CraftsRepository {
  const CraftsRepositoryImpl({required CraftsDataSource dataSource})
    : _dataSource = dataSource;

  final CraftsDataSource _dataSource;

  @override
  Future<Result<List<CraftEntity>>> getCrafts() => _dataSource.getCrafts();
}
