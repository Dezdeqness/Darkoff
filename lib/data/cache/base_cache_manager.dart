import 'dart:async';

import 'package:darkoff/data/cache/cache_value.dart';
import 'package:rxdart/rxdart.dart';

abstract class BaseCacheManager<T> {
  final BehaviorSubject<CacheValue<T>> _subject =
      BehaviorSubject<CacheValue<T>>.seeded(CacheValue<T>.loading());

  Stream<CacheValue<T>> get stream => _subject.stream;

  CacheValue<T> get value => _subject.value;

  StreamSubscription<CacheValue<T>> observe(
    void Function(CacheValue<T> value) onChange,
  ) {
    final subscription = _subject.listen(onChange);
    _load();
    return subscription;
  }

  Future<void> _load() async {
    await loadFromCache();
    await updateData();
  }

  Future<void> loadFromCache() async {
    final cached = await readCache();
    if (cached != null) {
      emitData(cached);
    } else {
      emitLoading();
    }
  }

  Future<void> updateData({bool force = false}) async {
    if (force || value is! CacheData) emitLoading();
    await performUpdate();
  }

  Future<T?> readCache();

  Future<void> performUpdate();

  void emit(CacheValue<T> value) {
    if (!_subject.isClosed) _subject.add(value);
  }

  void emitLoading() => emit(CacheValue<T>.loading());

  void emitData(T data) => emit(CacheValue<T>.data(data));

  void emitError(Object error, [StackTrace? stackTrace]) =>
      emit(CacheValue<T>.error(error, stackTrace));

  CacheDiff<E> diff<E>({
    required List<E> current,
    required List<E> incoming,
    required Object Function(E item) key,
  }) {
    final currentKeys = {for (final e in current) key(e)};
    final incomingKeys = {for (final e in incoming) key(e)};
    final toAdd =
        incoming.where((e) => !currentKeys.contains(key(e))).toList();
    final toRemove =
        current.where((e) => !incomingKeys.contains(key(e))).toList();
    return CacheDiff(toAdd: toAdd, toRemove: toRemove);
  }

  Future<void> dispose() => _subject.close();
}

class CacheDiff<E> {
  const CacheDiff({required this.toAdd, required this.toRemove});

  final List<E> toAdd;
  final List<E> toRemove;

  bool get isEmpty => toAdd.isEmpty && toRemove.isEmpty;
}