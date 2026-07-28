import 'package:darkoff/data/models/maps_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'maps_service.g.dart';

@RestApi()
abstract class MapsService {
  factory MapsService(Dio dio, {String baseUrl}) = _MapsService;

  @GET('{mode}/maps')
  Future<MapsResponse> getMaps(@Path('mode') String mode);
}
