import 'package:darkoff/data/datasources/ammo/ammo_data_source.dart';
import 'package:darkoff/domain/entities/ammo_entity.dart';
import 'package:darkoff/domain/repositories/ammo_repository.dart';
import 'package:result_dart/result_dart.dart';

class AmmoRepositoryImpl implements AmmoRepository {
  const AmmoRepositoryImpl({required AmmoDataSource dataSource})
    : _dataSource = dataSource;

  final AmmoDataSource _dataSource;

  @override
  Future<Result<List<AmmoEntity>>> getAmmo() => _dataSource.getAmmo();
}
