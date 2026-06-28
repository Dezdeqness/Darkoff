import 'package:darkoff/data/mapper/market_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/market_snapshot.graphql.dart';
import 'package:darkoff/domain/entities/market_item_entity.dart';
import 'package:darkoff/domain/repositories/market_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class MarketRepositoryImpl implements MarketRepository {
  const MarketRepositoryImpl({
    required DarkoffQLService service,
    required MarketMapper mapper,
  })  : _service = service,
        _mapper = mapper;

  final DarkoffQLService _service;
  final MarketMapper _mapper;

  @override
  Future<Result<List<MarketItemEntity>>> getMarketOverview() async {
    try {
      final result = await _service.getMarketSnapshot();

      if (result.hasException) {
        return failureOf(Exception(result.exception.toString()));
      }

      final data = result.data;
      if (data == null) return failureOf(Exception('Empty response'));

      final parsed = Query$DarkoffMarketSnapshot.fromJson(data);
      return successOf(_mapper.fromGraphqlList(parsed.items));
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
