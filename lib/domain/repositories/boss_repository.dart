import 'package:darkoff/domain/entities/boss_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class BossRepository {
  Future<Result<List<BossEntity>>> getBosses();
}
