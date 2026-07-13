import 'package:darkoff/data/mapper/trader_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/traders.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/trader_entity.dart';
import 'package:darkoff/domain/repositories/traders_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class TradersRepositoryImpl implements TradersRepository {
  const TradersRepositoryImpl({
    required DarkoffQLService service,
    required TraderMapper mapper,
  })  : _service = service,
        _mapper = mapper;

  final DarkoffQLService _service;
  final TraderMapper _mapper;

  @override
  Future<Result<List<TraderEntity>>> getTraders() async {
    try {
      final result = await _service.getTraders(
        gameMode: Enum$GameMode.pve,
      );

      if (result.hasException) {
        return failureOf(Exception(result.exception.toString()));
      }

      final data = result.data;
      if (data == null) {
        return failureOf(Exception('Empty response'));
      }

      final parsed = Query$DarkoffTraders.fromJson(data);

      return successOf(
        parsed.traders
            .whereType<Query$DarkoffTraders$traders>()
            .map((t) => _mapper.fromGraphql(t))
            .toList(),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
