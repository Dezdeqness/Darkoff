import 'package:darkoff/domain/entities/hideout_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class HideoutRepository {
  Future<Result<List<HideoutStationEntity>>> getStations();
}
