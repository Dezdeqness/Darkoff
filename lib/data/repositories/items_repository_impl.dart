import 'package:darkoff/data/mapper/item_mapper.dart';
import 'package:darkoff/data/service/darkoff_ql_service.dart';
import 'package:darkoff/data/service/qraphql/queries/items.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/domain/entities/item_entity.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  const ItemsRepositoryImpl({
    required DarkoffQLService service,
    required ItemMapper mapper,
  })  : _service = service,
        _mapper = mapper;

  final DarkoffQLService _service;
  final ItemMapper _mapper;

  @override
  Future<Result<List<ItemEntity>>> getItems({
    int limit = 50,
    int offset = 0,
    List<Enum$ItemType> types = const [],
  }) async {
    try {
      final result = await _service.getItems(
        gameMode: Enum$GameMode.pve,
        limit: limit,
        offset: offset,
        types: types,
      );

      if (result.hasException) {
        return failureOf(
          Exception(result.exception.toString()),
        );
      }

      final data = result.data;

      if (data == null) {
        return failureOf(
          Exception('Empty response'),
        );
      }

      final items = Query$DarkoffItems.fromJson(data);

      return successOf(
        items.items
            .whereType<Query$DarkoffItems$items>()
            .map((item) => _mapper.fromGraphql(item))
            .toList(),
      );
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }
}
