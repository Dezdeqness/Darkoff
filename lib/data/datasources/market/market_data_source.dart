import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:market_contract/market_contract.dart';
import 'package:result_dart/result_dart.dart';

const kMarketSnapshotIds = <String>[
  '5780cf7f2459777de4559322', // Dorm room 314 marked key (меченка)
  '57347ca924597744596b4e71', // Graphics card (GPU)
  '5c0530ee86f774697952d952', // LEDX Skin Transilluminator
  '5c052e6986f7746b207bc3c9', // Defibrillator
];

class MarketDataSource {
  MarketDataSource({required ItemsDao dao}) : _dao = dao;

  final ItemsDao _dao;

  Future<Result<List<MarketItemEntity>>> getMarketOverview() =>
      safeApiCall(() => _dao.getMarketItems(kMarketSnapshotIds));
}
