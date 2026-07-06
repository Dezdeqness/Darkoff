import 'package:darkoff/data/mapper/hideout_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/hideout.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/hideout_entity.dart';
import 'package:darkoff/domain/repositories/hideout_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class HideoutRepositoryImpl implements HideoutRepository {
  const HideoutRepositoryImpl({
    required DarkoffQLService service,
    required HideoutMapper mapper,
  })  : _service = service,
        _mapper = mapper;

  final DarkoffQLService _service;
  final HideoutMapper _mapper;

  @override
  Future<Result<List<HideoutStationEntity>>> getStations() async {
    try {
      final result = await _service.getHideout(
        gameMode: Enum$GameMode.pve,
      );

      if (result.hasException) {
        return failureOf(Exception(result.exception.toString()));
      }

      final data = result.data;
      if (data == null) {
        return failureOf(Exception('Empty response'));
      }

      final parsed = Query$DarkoffHideout.fromJson(data);

      return successOf(
        parsed.hideoutStations
            .whereType<Query$DarkoffHideout$hideoutStations>()
            .map((s) => _mapper.fromGraphql(s))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name)),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
