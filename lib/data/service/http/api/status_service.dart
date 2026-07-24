import 'package:darkoff/data/models/status_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'status_service.g.dart';

@RestApi()
abstract class StatusService {
  factory StatusService(Dio dio, {String baseUrl}) = _StatusService;

  @GET('status')
  Future<StatusResponse> getStatus();
}
