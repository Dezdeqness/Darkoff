import 'package:freezed_annotation/freezed_annotation.dart';

part 'preload_state.freezed.dart';

@freezed
class PreloadState with _$PreloadState {
  const factory PreloadState.initial() = _Initial;
  const factory PreloadState.loading({@Default(0) int loadedCount}) = _Loading;
  const factory PreloadState.completed() = _Completed;
  const factory PreloadState.error(String message) = _Error;
}
