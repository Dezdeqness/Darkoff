import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/craft_mapper.dart';
import 'package:darkoff/data/service/http/api/crafts_service.dart';
import 'package:darkoff/data/service/http/api/hideout_service.dart';
import 'package:darkoff/domain/entities/craft_entity.dart';
import 'package:result_dart/result_dart.dart';

class CraftsDataSource {
  CraftsDataSource({
    required CraftsService craftsService,
    required HideoutService hideoutService,
    required LocalizationDataSource localization,
    required ItemsDao itemsDao,
    required CraftMapper mapper,
  }) : _craftsService = craftsService,
       _hideoutService = hideoutService,
       _localization = localization,
       _itemsDao = itemsDao,
       _mapper = mapper;

  final CraftsService _craftsService;
  final HideoutService _hideoutService;
  final LocalizationDataSource _localization;
  final ItemsDao _itemsDao;
  final CraftMapper _mapper;

  static const _mode = GameMode.pve;

  Future<Result<List<CraftEntity>>> getCrafts() => safeApiCall(() async {
    final craftsFuture = _craftsService.getCrafts(_mode.apiValue);
    final hideoutFuture = _hideoutService.getHideout(_mode.apiValue);
    final stationLocFuture = _localization.localize(_mode, 'hideout');

    final crafts = (await craftsFuture).data;
    final stations = (await hideoutFuture).data;
    final stationLoc = await stationLocFuture;

    final items = await _itemsDao.getMiniInfoByIds(
      _mapper.collectItemIds(crafts),
    );

    return crafts
        .map(
          (c) => _mapper.map(
            c,
            stations: stations,
            stationLoc: stationLoc,
            items: items,
          ),
        )
        .toList();
  });
}
