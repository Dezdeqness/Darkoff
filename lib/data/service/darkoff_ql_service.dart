import 'dart:async';

import 'package:graphql/client.dart';
import 'package:darkoff/data/service/qraphql/queries/items.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/item_detail.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:logger/logger.dart';

const _maxRetries = 3;
const _retryDelay = Duration(seconds: 2);
const _requestTimeout = Duration(seconds: 30);

class DarkoffQLService {
  DarkoffQLService({
    required GraphQLClient client,
    required Logger logger,
  })  : _client = client,
        _logger = logger;

  final GraphQLClient _client;
  final Logger _logger;

  Future<QueryResult> getItems({
    Enum$LanguageCode language = Enum$LanguageCode.ru,
    Enum$GameMode gameMode = Enum$GameMode.regular,
    int limit = 100,
    int offset = 0,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffItems,
      variables: Variables$Query$DarkoffItems(
        language: language,
        gameMode: gameMode,
        limit: limit,
        offset: offset,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getItems(offset=$offset)');
  }

  Future<QueryResult> getItemDetail({
    required String id,
    Enum$LanguageCode language = Enum$LanguageCode.ru,
    Enum$GameMode gameMode = Enum$GameMode.pve,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffItemDetail,
      variables: Variables$Query$DarkoffItemDetail(
        id: id,
        language: language,
        gameMode: gameMode,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getItemDetail($id)');
  }

  Future<QueryResult> _queryWithRetry(
    QueryOptions options, {
    required String label,
  }) async {
    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        _logger.d('$label: attempt $attempt');

        final result = await _client.query(options).timeout(_requestTimeout);

        if (result.hasException) {
          final ex = result.exception;
          final isServerError = ex?.linkException != null;

          if (isServerError && attempt < _maxRetries) {
            _logger.w('$label: server error on attempt $attempt, retrying...');
            await Future.delayed(_retryDelay * attempt);
            continue;
          }
        }

        return result;
      } on TimeoutException {
        _logger.w('$label: timeout on attempt $attempt');
        if (attempt < _maxRetries) {
          await Future.delayed(_retryDelay * attempt);
          continue;
        }
        return QueryResult(
          options: options,
          exception: OperationException(
            linkException: ServerException(
              parsedResponse: null,
              originalException: TimeoutException('Request timed out after $_maxRetries attempts'),
            ),
          ),
          source: QueryResultSource.network,
        );
      } catch (e) {
        _logger.w('$label: error on attempt $attempt: $e');
        if (attempt < _maxRetries) {
          await Future.delayed(_retryDelay * attempt);
          continue;
        }
        rethrow;
      }
    }

    // Should not reach here, but just in case
    return _client.query(options);
  }

  Future<QueryResult> getTasks({
    Enum$LanguageCode language = Enum$LanguageCode.ru,
    Enum$GameMode gameMode = Enum$GameMode.regular,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffTasks,
      variables: Variables$Query$DarkoffTasks(
        language: language,
        gameMode: gameMode,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getTasks()');
  }

}
