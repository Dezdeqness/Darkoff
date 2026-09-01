import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/mapper/map_mapper.dart';
import 'package:darkoff/data/service/http/api/maps_service.dart';
import 'package:maps_contract/maps_contract.dart';
import 'package:result_dart/result_dart.dart';

class MapsDataSource {
  MapsDataSource({
    required MapsService mapsService,
    required LocalizationDataSource localization,
    required MapMapper mapper,
  }) : _mapsService = mapsService,
       _localization = localization,
       _mapper = mapper;

  final MapsService _mapsService;
  final LocalizationDataSource _localization;
  final MapMapper _mapper;

  static const _mode = GameMode.pve;

  Future<Result<List<MapEntity>>> getMaps() => safeApiCall(() async {
    final mapsFuture = _mapsService.getMaps(_mode.apiValue);
    final mapLocFuture = _localization.localize(_mode, 'maps');
    final data = (await mapsFuture).data;
    return _mapper.mapAll(
      data.maps.values.toList(),
      data.mobs,
      await mapLocFuture,
    );
  });
}
