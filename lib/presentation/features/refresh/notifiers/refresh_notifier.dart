import 'dart:async';

import 'package:darkoff/data/service/preload_service.dart';
import 'package:darkoff/presentation/features/refresh/state/refresh_event.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'refresh_notifier.g.dart';

@Riverpod(keepAlive: true)
class RefreshNotifier extends _$RefreshNotifier {
  late PreloadService _preloadService;
  final _controller = StreamController<RefreshEvent>.broadcast();

  Stream<RefreshEvent> get events => _controller.stream;

  @override
  bool build() {
    _preloadService = GetIt.instance<PreloadService>();
    ref.onDispose(_controller.close);
    return false;
  }

  Future<void> refresh() async {
    if (state) return;
    state = true;

    _controller.add(const RefreshEvent.started());

    try {
      await for (final loaded in _preloadService.preloadItems()) {
        _controller.add(RefreshEvent.progress(loaded));
      }
      _controller.add(const RefreshEvent.completed());
    } catch (e) {
      _controller.add(RefreshEvent.error(e.toString()));
    } finally {
      state = false;
    }
  }
}
