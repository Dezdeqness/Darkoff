import 'package:darkoff/data/models/items_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'items_service.g.dart';

@RestApi()
abstract class ItemsService {
  factory ItemsService(Dio dio, {String baseUrl}) = _ItemsService;

  @GET('{mode}/items')
  Future<ItemsResponse> getItems(@Path('mode') String mode);
}
