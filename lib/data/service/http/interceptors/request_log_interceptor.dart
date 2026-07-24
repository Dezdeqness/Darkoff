import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class RequestLogInterceptor extends Interceptor {
  RequestLogInterceptor(this._logger);

  final Logger _logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final params = options.queryParameters.isEmpty
        ? ''
        : ' ${options.queryParameters}';
    _logger.d('→ ${options.method} ${options.uri}$params');
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    _logger.d('← ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }
}
