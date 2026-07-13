import 'package:darkoff/data/mapper/barter_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/barters.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:darkoff/domain/repositories/barters_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class BartersRepositoryImpl implements BartersRepository {
  const BartersRepositoryImpl({
    required DarkoffQLService service,
    required BarterMapper mapper,
  })  : _service = service,
        _mapper = mapper;

  final DarkoffQLService _service;
  final BarterMapper _mapper;

  @override
  Future<Result<List<BarterEntity>>> getBarters() async {
    try {
      final result = await _service.getBarters(
        gameMode: Enum$GameMode.pve,
      );

      if (result.hasException) {
        return failureOf(Exception(result.exception.toString()));
      }

      final data = result.data;
      if (data == null) {
        return failureOf(Exception('Empty response'));
      }

      final parsed = Query$DarkoffBarters.fromJson(data);

      return successOf(
        (parsed.barters ?? [])
            .whereType<Query$DarkoffBarters$barters>()
            .map((b) => _mapper.fromGraphql(b))
            .toList(),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
