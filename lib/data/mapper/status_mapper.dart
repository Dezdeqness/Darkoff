import 'package:darkoff/data/service/qraphql/queries/server_status.graphql.dart';
import 'package:darkoff/domain/entities/server_status_entity.dart';

class StatusMapper {
  ServerStatusEntity? fromGraphql(
    Query$DarkoffServerStatus$status status,
  ) {
    final general = status.generalStatus;
    if (general == null) return null;
    return ServerStatusEntity(
      name: general.name,
      status: general.status,
      statusCode: general.statusCode,
    );
  }
}
