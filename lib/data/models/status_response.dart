import 'package:json_annotation/json_annotation.dart';

part 'status_response.g.dart';

@JsonSerializable(createToJson: false)
class StatusResponse {
  const StatusResponse({this.data = const StatusData()});

  factory StatusResponse.fromJson(Map<String, dynamic> json) =>
      _$StatusResponseFromJson(json);

  final StatusData data;
}

@JsonSerializable(createToJson: false)
class StatusData {
  const StatusData({this.generalStatus, this.currentStatuses = const []});

  factory StatusData.fromJson(Map<String, dynamic> json) =>
      _$StatusDataFromJson(json);

  final StatusInfoApi? generalStatus;
  final List<StatusInfoApi> currentStatuses;
}

@JsonSerializable(createToJson: false)
class StatusInfoApi {
  const StatusInfoApi({this.name, this.status, this.statusCode});

  factory StatusInfoApi.fromJson(Map<String, dynamic> json) =>
      _$StatusInfoApiFromJson(json);

  final String? name;
  final int? status;
  final String? statusCode;
}
