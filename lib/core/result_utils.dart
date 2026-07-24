import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

Future<Result<T>> safeApiCall<T extends Object>(Future<T> Function() body) async {
  try {
    return successOf(await body());
  } catch (e) {
    return failureOf(Exception(e.toString()));
  }
}
