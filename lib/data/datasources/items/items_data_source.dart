import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/item_mapper.dart';
import 'package:darkoff/data/service/http/api/items_service.dart';
import 'package:darkoff/data/service/http/api/prices_service.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:result_dart/functions.dart';
import 'package:result_dart/result_dart.dart';

const _mode = GameMode.pve;

class ItemsDataSource {
  ItemsDataSource({
    required ItemsService itemsService,
    required TradersService tradersService,
    required LocalizationDataSource localization,
    required PricesService pricesService,
    required ItemMapper mapper,
    required ItemsDao dao,
  }) : _itemsService = itemsService,
       _tradersService = tradersService,
       _localization = localization,
       _pricesService = pricesService,
       _mapper = mapper,
       _dao = dao;

  final ItemsService _itemsService;
  final TradersService _tradersService;
  final LocalizationDataSource _localization;
  final PricesService _pricesService;
  final ItemMapper _mapper;
  final ItemsDao _dao;

  Future<Result<List<ItemDetailEntity>>> getItems() => safeApiCall(() async {
    final itemsFuture = _itemsService.getItems(_mode.apiValue);
    final itemLocFuture = _localization.localize(_mode, 'items');
    final tradersFuture = _tradersService.getTraders(_mode.apiValue);
    final traderLocFuture = _localization.localize(_mode, 'traders');

    return _mapper.mapAll(
      data: (await itemsFuture).data,
      traders: (await tradersFuture).data,
      itemLoc: await itemLocFuture,
      traderLoc: await traderLocFuture,
    );
  });

  Future<Result<ItemDetailEntity>> getItemDetail(String id) async {
    try {
      final cached = await _dao.getItemDetailById(id);
      if (cached == null) return failureOf(Exception('Item not found: $id'));
      return successOf(await _withFreshFleaPrice(cached));
    } catch (e) {
      return failureOf(Exception(e.toString()));
    }
  }

  Future<ItemDetailEntity> _withFreshFleaPrice(ItemDetailEntity item) async {
    try {
      final history = await _pricesService.getPriceHistory(
        _mode.apiValue,
        item.id,
      );
      final latest = history.data.isEmpty ? null : history.data.last;
      final price = latest?.price?.toInt();
      if (price == null) return item;

      final priceMin = latest?.priceMin?.toInt();
      final ts = latest?.timestamp?.toInt();
      return item.copyWith(
        avg24hPrice: price,
        low24hPrice: priceMin ?? item.low24hPrice,
        lastLowPrice: priceMin ?? item.lastLowPrice,
        lastOfferCount: latest?.offerCount?.toInt() ?? item.lastOfferCount,
        updated: ts != null
            ? DateTime.fromMillisecondsSinceEpoch(ts).toIso8601String()
            : item.updated,
        sellFor: [
          for (final p in item.sellFor)
            p.vendorTypename == 'FleaMarket'
                ? p.copyWith(price: price, priceRUB: price)
                : p,
        ],
      );
    } catch (_) {
      return item;
    }
  }
}
