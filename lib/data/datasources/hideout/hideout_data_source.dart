import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/hideout_mapper.dart';
import 'package:darkoff/data/service/http/api/hideout_service.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:hideout_contract/hideout_contract.dart';
import 'package:result_dart/result_dart.dart';

const _mode = GameMode.pve;

class HideoutDataSource {
  HideoutDataSource({
    required HideoutService hideoutService,
    required TradersService tradersService,
    required LocalizationDataSource localization,
    required ItemsDao itemsDao,
    required HideoutMapper mapper,
  }) : _hideoutService = hideoutService,
       _tradersService = tradersService,
       _localization = localization,
       _itemsDao = itemsDao,
       _mapper = mapper;

  final HideoutService _hideoutService;
  final TradersService _tradersService;
  final LocalizationDataSource _localization;
  final ItemsDao _itemsDao;
  final HideoutMapper _mapper;


  Future<Result<List<HideoutStationEntity>>> getStations() => safeApiCall(() async {
    final hideoutFuture = _hideoutService.getHideout(_mode.apiValue);
    final stationLocFuture = _localization.localize(_mode, 'hideout');
    final tradersFuture = _tradersService.getTraders(_mode.apiValue);
    final traderLocFuture = _localization.localize(_mode, 'traders');

    final stations = (await hideoutFuture).data;
    final stationLoc = await stationLocFuture;
    final traders = (await tradersFuture).data;
    final traderLoc = await traderLocFuture;

    final items = await _itemsDao.getMiniInfoByIds(
      _mapper.collectItemIds(stations.values),
    );

    return stations.values
        .map(
          (s) => _mapper.map(
            s,
            stations: stations,
            stationLoc: stationLoc,
            traders: traders,
            traderLoc: traderLoc,
            items: items,
          ),
        )
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  });
}
