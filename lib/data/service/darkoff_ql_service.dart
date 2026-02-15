import 'package:graphql/client.dart';
import 'package:darkoff/data/service/qraphql/queries/items.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';

class DarkoffQLService {
  final GraphQLClient client;

  DarkoffQLService({required this.client});

  Future<QueryResult> getItems({
    String language = 'ru',
    String gameMode = 'regular',
    int limit = 100,
    int offset = 0,
    List<Enum$ItemType> types = const [],
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffItems,
      variables: Variables$Query$DarkoffItems(
        language: language == 'ru' ? Enum$LanguageCode.ru : Enum$LanguageCode.en,
        gameMode: gameMode == 'regular' ? Enum$GameMode.regular : Enum$GameMode.pve,
        limit: limit,
        offset: offset,
        types: types,
      ).toJson(),
    );

    return await client.query(options);
  }
}
