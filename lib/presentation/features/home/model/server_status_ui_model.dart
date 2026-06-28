import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_status_ui_model.freezed.dart';

enum ServerStatusLevel { operational, updating, unstable, offline, unknown }

@freezed
abstract class ServerStatusUiModel with _$ServerStatusUiModel {
  const factory ServerStatusUiModel({
    required String statusLabel,
    required String badgeLabel,
    required ServerStatusLevel level,
  }) = _ServerStatusUiModel;
}
