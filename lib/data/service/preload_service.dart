import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/local/dao/reference_dao.dart';
import 'package:darkoff/data/local/dao/tasks_dao.dart';
import 'package:darkoff/data/mapper/trader_mapper.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:darkoff/domain/repositories/tasks_repository.dart';
import 'package:logger/logger.dart';
import 'package:result_dart/result_dart.dart';

class PreloadService {
  PreloadService({
    required ItemsRepository repository,
    required ItemsDao dao,
    required TasksRepository tasksRepository,
    required TasksDao tasksDao,
    required ReferenceDao referenceDao,
    required TradersService tradersService,
    required TraderMapper traderMapper,
    required LocalizationDataSource localization,
    required Logger logger,
  }) : _repository = repository,
       _dao = dao,
       _tasksRepository = tasksRepository,
       _tasksDao = tasksDao,
       _referenceDao = referenceDao,
       _tradersService = tradersService,
       _traderMapper = traderMapper,
       _localization = localization,
       _logger = logger;

  final ItemsRepository _repository;
  final ItemsDao _dao;
  final TasksRepository _tasksRepository;
  final TasksDao _tasksDao;
  final ReferenceDao _referenceDao;
  final TradersService _tradersService;
  final TraderMapper _traderMapper;
  final LocalizationDataSource _localization;
  final Logger _logger;

  Future<bool> hasLocalData() async {
    final itemCount = await _dao.getItemCount();
    final taskCount = await _tasksDao.getTaskCount();
    _logger.i('Local item count: $itemCount, task count: $taskCount');
    return itemCount > 0 && taskCount > 0;
  }

  Stream<int> preloadItems() async* {
    await _loadTraders();
    yield await _loadItems();
    final tasks = await _loadTasks();
    await _loadMapReferences(tasks);
  }

  Future<void> _loadTraders() async {
    try {
      final response = await _tradersService.getTraders(GameMode.pve.apiValue);
      final traderLoc = await _localization.localize(GameMode.pve, 'traders');
      await _referenceDao.insertTraders(
        _traderMapper.toReferences(response.data, traderLoc),
      );
    } catch (e) {
      _logger.w('Failed to preload traders: $e');
    }
  }

  Future<int> _loadItems() async {
    _logger.i('Fetching items...');
    final items = _fetch(await _repository.getItems(), 'items');
    if (items == null) throw Exception('Failed to fetch items');
    await _dao.insertAllItems(items);
    _logger.i('Preload complete: ${items.length} items loaded');
    return items.length;
  }

  Future<List<TaskEntity>> _loadTasks() async {
    _logger.i('Fetching tasks...');
    final tasks = _fetch(await _tasksRepository.getRemoteTasks(), 'tasks');
    if (tasks == null) throw Exception('Failed to fetch tasks');
    await _tasksDao.insertAllTasks(tasks);
    _logger.i('Preload complete: ${tasks.length} tasks loaded');
    return tasks;
  }

  Future<void> _loadMapReferences(List<TaskEntity> tasks) async {
    final maps = <String, String>{};
    for (final task in tasks) {
      final id = task.mapId;
      final name = task.mapName;
      if (id != null && name != null) maps[id] = name;
    }
    await _referenceDao.insertMaps(maps);
  }

  T? _fetch<T extends Object>(Result<T> result, String what) => result.fold(
    (value) => value,
    (error) {
      _logger.w('Failed to fetch $what: $error');
      return null;
    },
  );
}
