import 'package:darkoff/data/models/crafts_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'crafts_service.g.dart';

@RestApi()
abstract class CraftsService {
  factory CraftsService(Dio dio, {String baseUrl}) = _CraftsService;

  @GET('{mode}/crafts')
  Future<CraftsResponse> getCrafts(@Path('mode') String mode);
}
