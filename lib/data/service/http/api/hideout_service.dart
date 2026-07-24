import 'package:darkoff/data/models/hideout_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'hideout_service.g.dart';

@RestApi()
abstract class HideoutService {
  factory HideoutService(Dio dio, {String baseUrl}) = _HideoutService;

  @GET('{mode}/hideout')
  Future<HideoutResponse> getHideout(@Path('mode') String mode);
}
