import 'package:freezed_annotation/freezed_annotation.dart';

part 'refresh_event.freezed.dart';

@freezed
class RefreshEvent with _$RefreshEvent {
  const factory RefreshEvent.started() = _Started;
  const factory RefreshEvent.progress(int loadedCount) = _Progress;
  const factory RefreshEvent.completed() = _Completed;
  const factory RefreshEvent.error(String message) = _Error;
}
