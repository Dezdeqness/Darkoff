import 'package:darkoff/data/mapper/ammo_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/ammo.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/ammo_entity.dart';
import 'package:darkoff/domain/repositories/ammo_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class AmmoRepositoryImpl implements AmmoRepository {
  const AmmoRepositoryImpl({
    required DarkoffQLService service,
    required AmmoMapper mapper,
  })  : _service = service,
        _mapper = mapper;

  final DarkoffQLService _service;
  final AmmoMapper _mapper;

  @override
  Future<Result<List<AmmoEntity>>> getAmmo() async {
    try {
      final result = await _service.getAmmo(
        gameMode: Enum$GameMode.pve,
      );

      if (result.hasException) {
        return failureOf(Exception(result.exception.toString()));
      }

      final data = result.data;
      if (data == null) {
        return failureOf(Exception('Empty response'));
      }

      final parsed = Query$DarkoffAmmo.fromJson(data);

      return successOf(
        (parsed.ammo ?? [])
            .whereType<Query$DarkoffAmmo$ammo>()
            .map((a) => _mapper.fromGraphql(a))
            .toList(),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
