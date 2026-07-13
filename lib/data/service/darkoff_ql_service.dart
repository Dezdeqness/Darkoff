import 'dart:async';

import 'package:darkoff/core/localization/language_store.dart';
import 'package:graphql/client.dart';
import 'package:darkoff/data/service/qraphql/queries/items.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/hideout.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/ammo.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/flea_market.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/item_detail.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/market_snapshot.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/traders.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/server_status.graphql.dart';
import 'package:darkoff/data/service/qraphql/schema.graphql.dart';
import 'package:darkoff/data/service/qraphql/queries/tasks.graphql.dart';
import 'package:logger/logger.dart';

const _maxRetries = 3;
const _retryDelay = Duration(seconds: 2);
const _requestTimeout = Duration(seconds: 30);

class DarkoffQLService {
  DarkoffQLService({
    required GraphQLClient client,
    required Logger logger,
    required LanguageStore languageStore,
  })  : _client = client,
        _logger = logger,
        _languageStore = languageStore;

  final GraphQLClient _client;
  final Logger _logger;
  final LanguageStore _languageStore;

  Enum$LanguageCode _resolveLanguage(Enum$LanguageCode? language) =>
      language ?? _languageStore.language;

  Future<QueryResult> getItems({
    Enum$LanguageCode? language,
    Enum$GameMode gameMode = Enum$GameMode.pve,
    int limit = 100,
    int offset = 0,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffItems,
      variables: Variables$Query$DarkoffItems(
        language: _resolveLanguage(language),
        gameMode: gameMode,
        limit: limit,
        offset: offset,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getItems(offset=$offset)');
  }

  Future<QueryResult> getTasks({
    Enum$LanguageCode? language,
    Enum$GameMode gameMode = Enum$GameMode.pve,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffTasks,
      variables: Variables$Query$DarkoffTasks(
        language: _resolveLanguage(language),
        gameMode: gameMode,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
      errorPolicy: ErrorPolicy.all,
    );

    return _queryWithRetry(options, label: 'getTasks()');
  }

  Future<QueryResult> getMarketSnapshot({
    Enum$LanguageCode? language,
    Enum$GameMode gameMode = Enum$GameMode.pve,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffMarketSnapshot,
      variables: Variables$Query$DarkoffMarketSnapshot(
        ids: [
          '5780cf7f2459777de4559322', // Dorm room 314 marked key (меченка)
          '57347ca924597744596b4e71', // Graphics card (GPU)
          '5c0530ee86f774697952d952', // LEDX Skin Transilluminator
          '5c052e6986f7746b207bc3c9', // Defibrillator
        ],
        language: _resolveLanguage(language),
        gameMode: gameMode,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getMarketSnapshot()');
  }

  Future<QueryResult> getServerStatus() async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffServerStatus,
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getServerStatus()');
  }

  Future<QueryResult> getHideout({
    Enum$LanguageCode? language,
    Enum$GameMode gameMode = Enum$GameMode.pve,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffHideout,
      variables: Variables$Query$DarkoffHideout(
        language: _resolveLanguage(language),
        gameMode: gameMode,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getHideout()');
  }

  Future<QueryResult> getFleaItems({
    Enum$LanguageCode? language,
    Enum$GameMode gameMode = Enum$GameMode.pve,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffFleaMarket,
      variables: Variables$Query$DarkoffFleaMarket(
        language: _resolveLanguage(language),
        gameMode: gameMode,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getFleaItems()');
  }

  Future<QueryResult> getAmmo({
    Enum$LanguageCode? language,
    Enum$GameMode gameMode = Enum$GameMode.pve,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffAmmo,
      variables: Variables$Query$DarkoffAmmo(
        language: _resolveLanguage(language),
        gameMode: gameMode,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getAmmo()');
  }

  Future<QueryResult> getTraders({
    Enum$LanguageCode? language,
    Enum$GameMode gameMode = Enum$GameMode.pve,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffTraders,
      variables: Variables$Query$DarkoffTraders(
        language: _resolveLanguage(language),
        gameMode: gameMode,
      ).toJson(),
      fetchPolicy: FetchPolicy.networkOnly,
    );

    return _queryWithRetry(options, label: 'getTraders()');
  }

  Future<QueryResult> getItemDetail({
    required String id,
    Enum$LanguageCode? language,
    Enum$GameMode gameMode = Enum$GameMode.pve,
  }) async {
    final options = QueryOptions(
      document: documentNodeQueryDarkoffItemDetail,
      variables: Variables$Query$DarkoffItemDetail(
        id: id,
        language: _resolveLanguage(language),
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
}
