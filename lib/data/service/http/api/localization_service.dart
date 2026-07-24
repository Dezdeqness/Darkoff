import 'package:darkoff/data/models/locale_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'localization_service.g.dart';

@RestApi()
abstract class LocalizationService {
  factory LocalizationService(Dio dio, {String baseUrl}) = _LocalizationService;

  @GET('{mode}/{name}_{lang}')
  Future<LocaleResponse> getLocale(
    @Path('mode') String mode,
    @Path('name') String name,
    @Path('lang') String lang,
  );
}
