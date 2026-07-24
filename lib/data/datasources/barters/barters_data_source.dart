import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/barter_mapper.dart';
import 'package:darkoff/data/service/http/api/barters_service.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/domain/entities/barter_entity.dart';
import 'package:result_dart/result_dart.dart';

const _mode = GameMode.pve;

class BartersDataSource {
  BartersDataSource({
    required BartersService bartersService,
    required TradersService tradersService,
    required LocalizationDataSource localization,
    required ItemsDao itemsDao,
    required BarterMapper mapper,
  }) : _bartersService = bartersService,
       _tradersService = tradersService,
       _localization = localization,
       _itemsDao = itemsDao,
       _mapper = mapper;

  final BartersService _bartersService;
  final TradersService _tradersService;
  final LocalizationDataSource _localization;
  final ItemsDao _itemsDao;
  final BarterMapper _mapper;

  Future<Result<List<BarterEntity>>> getBarters() => safeApiCall(() async {
    final bartersFuture = _bartersService.getBarters(_mode.apiValue);
    final tradersFuture = _tradersService.getTraders(_mode.apiValue);
    final traderLocFuture = _localization.localize(_mode, 'traders');

    final barters = (await bartersFuture).data;
    final traders = (await tradersFuture).data;
    final traderLoc = await traderLocFuture;

    final items = await _itemsDao.getMiniInfoByIds(
      _mapper.collectItemIds(barters),
    );

    return barters
        .map(
          (b) => _mapper.map(
            b,
            traders: traders,
            traderLoc: traderLoc,
            items: items,
          ),
        )
        .toList();
  });
}
