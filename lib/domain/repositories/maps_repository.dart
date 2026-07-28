import 'package:darkoff/domain/entities/map_entity.dart';
import 'package:result_dart/result_dart.dart';

abstract interface class MapsRepository {
  Future<Result<List<MapEntity>>> getMaps();
}
