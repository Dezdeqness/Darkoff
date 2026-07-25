import 'package:darkoff/data/datasources/boss/boss_data_source.dart';
import 'package:darkoff/domain/entities/boss_entity.dart';
import 'package:darkoff/domain/repositories/boss_repository.dart';
import 'package:result_dart/result_dart.dart';

class BossRepositoryImpl implements BossRepository {
  const BossRepositoryImpl({required BossDataSource dataSource})
    : _dataSource = dataSource;

  final BossDataSource _dataSource;

  @override
  Future<Result<List<BossEntity>>> getBosses() => _dataSource.getBosses();
}
