import 'package:dio/dio.dart';

const _ttl = Duration(minutes: 10);

class InMemoryCacheInterceptor extends Interceptor {
  final _cache = <String, _CacheEntry>{};

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.method != 'GET') return handler.next(options);
    final key = options.uri.toString();
    final entry = _cache[key];
    if (entry != null && DateTime.now().difference(entry.at) < _ttl) {
      return handler.resolve(entry.response);
    }
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (response.requestOptions.method == 'GET') {
      _cache[response.requestOptions.uri.toString()] = _CacheEntry(
        response,
        DateTime.now(),
      );
    }
    handler.next(response);
  }
}

class _CacheEntry {
  _CacheEntry(this.response, this.at);

  final Response<dynamic> response;
  final DateTime at;
}
