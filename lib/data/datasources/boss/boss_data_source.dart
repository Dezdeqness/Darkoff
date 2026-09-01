import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/mapper/boss_mapper.dart';
import 'package:darkoff/data/service/http/api/maps_service.dart';
import 'package:boss_contract/boss_contract.dart';
import 'package:result_dart/result_dart.dart';

const _mode = GameMode.pve;

class BossDataSource {
  BossDataSource({
    required MapsService mapsService,
    required LocalizationDataSource localization,
    required BossMapper mapper,
  }) : _mapsService = mapsService,
       _localization = localization,
       _mapper = mapper;

  final MapsService _mapsService;
  final LocalizationDataSource _localization;
  final BossMapper _mapper;

  Future<Result<List<BossEntity>>> getBosses() => safeApiCall(() async {
    final mapsFuture = _mapsService.getMaps(_mode.apiValue);
    final mapLocFuture = _localization.localize(_mode, 'maps');
    final data = (await mapsFuture).data;
    return _mapper.bossesAll(
      data.maps.values.toList(),
      data.mobs,
      await mapLocFuture,
    );
  });
}
