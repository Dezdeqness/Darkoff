import 'package:darkoff/data/models/price_history_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'prices_service.g.dart';

@RestApi()
abstract class PricesService {
  factory PricesService(Dio dio, {String baseUrl}) = _PricesService;

  @GET('{mode}/prices/{itemId}')
  Future<PriceHistoryResponse> getPriceHistory(
    @Path('mode') String mode,
    @Path('itemId') String itemId,
  );
}
