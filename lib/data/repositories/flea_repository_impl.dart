import 'package:darkoff/data/mapper/flea_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/flea_market.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/flea_item_entity.dart';
import 'package:darkoff/domain/repositories/flea_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class FleaRepositoryImpl implements FleaRepository {
  const FleaRepositoryImpl({
    required DarkoffQLService service,
    required FleaMapper mapper,
  })  : _service = service,
        _mapper = mapper;

  final DarkoffQLService _service;
  final FleaMapper _mapper;

  @override
  Future<Result<List<FleaItemEntity>>> getFleaItems() async {
    try {
      final result = await _service.getFleaItems(
        gameMode: Enum$GameMode.pve,
      );

      if (result.hasException) {
        return failureOf(Exception(result.exception.toString()));
      }

      final data = result.data;
      if (data == null) return failureOf(Exception('Empty response'));

      final parsed = Query$DarkoffFleaMarket.fromJson(data);

      return successOf(
        parsed.items
            .whereType<Query$DarkoffFleaMarket$items>()
            .where((i) => (i.avg24hPrice ?? 0) > 0)
            .map((i) => _mapper.fromGraphql(i))
            .toList(),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
