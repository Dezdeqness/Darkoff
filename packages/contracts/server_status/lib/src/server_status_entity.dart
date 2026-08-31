import 'package:freezed_annotation/freezed_annotation.dart';

part 'server_status_entity.freezed.dart';

@freezed
abstract class ServerStatusEntity with _$ServerStatusEntity {
  const factory ServerStatusEntity({
    required String name,
    required int status,
    required String statusCode,
  }) = _ServerStatusEntity;
}
