import 'package:freezed_annotation/freezed_annotation.dart';

part 'cache_value.freezed.dart';

@freezed
sealed class CacheValue<T> with _$CacheValue<T> {
  const factory CacheValue.loading() = CacheLoading<T>;

  const factory CacheValue.data(T data) = CacheData<T>;

  const factory CacheValue.error(Object error, [StackTrace? stackTrace]) =
      CacheError<T>;
}
