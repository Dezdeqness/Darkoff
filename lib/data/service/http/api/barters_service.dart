import 'package:darkoff/data/models/barters_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'barters_service.g.dart';

@RestApi()
abstract class BartersService {
  factory BartersService(Dio dio, {String baseUrl}) = _BartersService;

  @GET('{mode}/barters')
  Future<BartersResponse> getBarters(@Path('mode') String mode);
}
