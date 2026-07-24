import 'package:darkoff/data/models/traders_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'traders_service.g.dart';

@RestApi()
abstract class TradersService {
  factory TradersService(Dio dio, {String baseUrl}) = _TradersService;

  @GET('{mode}/traders')
  Future<TradersResponse> getTraders(@Path('mode') String mode);
}
