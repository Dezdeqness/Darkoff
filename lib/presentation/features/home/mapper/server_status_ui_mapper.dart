import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/domain/entities/server_status_entity.dart';
import 'package:darkoff/presentation/features/home/model/server_status_ui_model.dart';

class ServerStatusUiMapper {
  ServerStatusUiModel fromEntity(ServerStatusEntity? status) {
    if (status == null) {
      return ServerStatusUiModel(
        statusLabel: tr.common.value.unknown,
        badgeLabel: tr.common.value.unknownUpper,
        level: ServerStatusLevel.unknown,
      );
    }
    return switch (status.status) {
      0 => ServerStatusUiModel(
          statusLabel: tr.serverStatus.status.online,
          badgeLabel: tr.serverStatus.badge.operational,
          level: ServerStatusLevel.operational,
        ),
      1 => ServerStatusUiModel(
          statusLabel: tr.serverStatus.status.updating,
          badgeLabel: tr.serverStatus.badge.updating,
          level: ServerStatusLevel.updating,
        ),
      2 => ServerStatusUiModel(
          statusLabel: tr.serverStatus.status.unstable,
          badgeLabel: tr.serverStatus.badge.unstable,
          level: ServerStatusLevel.unstable,
        ),
      _ => ServerStatusUiModel(
          statusLabel: tr.serverStatus.status.down,
          badgeLabel: tr.serverStatus.badge.offline,
          level: ServerStatusLevel.offline,
        ),
    };
  }
}
