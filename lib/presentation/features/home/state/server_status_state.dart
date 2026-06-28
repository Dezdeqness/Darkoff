import 'package:darkoff/presentation/features/home/model/server_status_ui_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_status_state.freezed.dart';

@freezed
class ServerStatusState with _$ServerStatusState {
  const factory ServerStatusState.initial() = ServerStatusInitial;
  const factory ServerStatusState.loading() = ServerStatusLoading;
  const factory ServerStatusState.loaded(ServerStatusUiModel status) =
      ServerStatusLoaded;
  const factory ServerStatusState.error(String message) = ServerStatusError;
}
