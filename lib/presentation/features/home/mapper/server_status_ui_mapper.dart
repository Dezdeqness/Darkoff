import 'package:darkoff/domain/entities/server_status_entity.dart';
import 'package:darkoff/presentation/features/home/model/server_status_ui_model.dart';

class ServerStatusUiMapper {
  ServerStatusUiModel fromEntity(ServerStatusEntity? status) {
    if (status == null) {
      return const ServerStatusUiModel(
        statusLabel: 'Unknown',
        badgeLabel: 'UNKNOWN',
        level: ServerStatusLevel.unknown,
      );
    }
    return switch (status.status) {
      0 => const ServerStatusUiModel(
          statusLabel: 'Online',
          badgeLabel: 'OPERATIONAL',
          level: ServerStatusLevel.operational,
        ),
      1 => const ServerStatusUiModel(
          statusLabel: 'Updating',
          badgeLabel: 'UPDATING',
          level: ServerStatusLevel.updating,
        ),
      2 => const ServerStatusUiModel(
          statusLabel: 'Unstable',
          badgeLabel: 'UNSTABLE',
          level: ServerStatusLevel.unstable,
        ),
      _ => const ServerStatusUiModel(
          statusLabel: 'Down',
          badgeLabel: 'OFFLINE',
          level: ServerStatusLevel.offline,
        ),
    };
  }
}
