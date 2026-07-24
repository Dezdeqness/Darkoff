import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/trader_mapper.dart';
import 'package:darkoff/data/models/barter_api.dart';
import 'package:darkoff/data/service/http/api/barters_service.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/domain/entities/trader_entity.dart';
import 'package:result_dart/result_dart.dart';

class TradersDataSource {
  TradersDataSource({
    required TradersService tradersService,
    required BartersService bartersService,
    required LocalizationDataSource localization,
    required ItemsDao itemsDao,
    required TraderMapper mapper,
  }) : _tradersService = tradersService,
       _bartersService = bartersService,
       _localization = localization,
       _itemsDao = itemsDao,
       _mapper = mapper;

  final TradersService _tradersService;
  final BartersService _bartersService;
  final LocalizationDataSource _localization;
  final ItemsDao _itemsDao;
  final TraderMapper _mapper;

  static const _mode = GameMode.pve;

  Future<Result<List<TraderEntity>>> getTraders() => safeApiCall(() async {
    final tradersFuture = _tradersService.getTraders(_mode.apiValue);
    final traderLocFuture = _localization.localize(_mode, 'traders');
    final bartersFuture = _bartersService.getBarters(_mode.apiValue);

    final traders = (await tradersFuture).data;
    final traderLoc = await traderLocFuture;
    final barters = (await bartersFuture).data;

    final bartersByTrader = <String, List<BarterApi>>{};
    for (final b in barters) {
      if (b.trader != null) (bartersByTrader[b.trader!] ??= []).add(b);
    }

    final cashOffers = await _itemsDao.getTraderCashOffers();
    final items = await _itemsDao.getMiniInfoByIds(
      _mapper.collectItemIds(barters),
    );

    return traders.values
        .map(
          (trader) => _mapper.map(
            trader,
            traderLoc: traderLoc,
            cashOffers: cashOffers[trader.id] ?? const [],
            barters: bartersByTrader[trader.id] ?? const [],
            items: items,
          ),
        )
        .toList();
  });
}
