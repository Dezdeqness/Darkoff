import 'package:ammo_contract/src/ammo_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class AmmoRepository {
  Future<Result<List<AmmoEntity>>> getAmmo();
}
