import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

const _maxRetries = 3;
const _retryDelay = Duration(seconds: 2);

class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._logger, this._dio);

  final Logger _logger;

  final Dio Function() _dio;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final attempt =
        (err.requestOptions.extra['retry_attempt'] as int? ?? 0) + 1;
    if (!_retryable(err) || attempt > _maxRetries) return handler.next(err);

    _logger.w('GET ${err.requestOptions.path}: ${err.type} — retry $attempt');
    await Future<void>.delayed(_retryDelay * attempt);
    try {
      final options = err.requestOptions..extra['retry_attempt'] = attempt;
      final response = await _dio().fetch<dynamic>(options);
      handler.resolve(response);
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _retryable(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return true;
      case DioExceptionType.badResponse:
        return (err.response?.statusCode ?? 0) >= 500;
      default:
        return false;
    }
  }
}
