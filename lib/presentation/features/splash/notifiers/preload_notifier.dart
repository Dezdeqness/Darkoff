import 'package:darkoff/data/service/preload_service.dart';
import 'package:darkoff/presentation/features/splash/state/preload_state.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'preload_notifier.g.dart';

@riverpod
class PreloadNotifier extends _$PreloadNotifier {
  late PreloadService _preloadService;

  @override
  PreloadState build() {
    _preloadService = GetIt.instance<PreloadService>();
    return const PreloadState.initial();
  }

  Future<void> startPreload() async {
    final fresh = await _preloadService.hasFreshLocalData();
    if (fresh) {
      state = const PreloadState.completed();
      return;
    }

    await _doPreload();
  }

  Future<void> _doPreload() async {
    state = const PreloadState.loading();

    try {
      await for (final loaded in _preloadService.preloadItems()) {
        state = PreloadState.loading(loadedCount: loaded);
      }
      state = const PreloadState.completed();
    } catch (e) {
      state = PreloadState.error(e.toString());
    }
  }

  Future<void> retry() async {
    await _doPreload();
  }
}
