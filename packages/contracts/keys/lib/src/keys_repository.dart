import 'package:keys_contract/src/key_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class KeysRepository {
  Future<Result<List<KeyEntity>>> getKeys();
}
