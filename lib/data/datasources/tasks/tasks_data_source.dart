import 'package:darkoff/core/config/game_mode.dart';
import 'package:darkoff/core/result_utils.dart';
import 'package:darkoff/data/datasources/localization/localization_data_source.dart';
import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/mapper/task_mapper.dart';
import 'package:darkoff/data/service/http/api/tasks_service.dart';
import 'package:darkoff/data/service/http/api/traders_service.dart';
import 'package:tasks_contract/tasks_contract.dart';
import 'package:result_dart/result_dart.dart';

class TasksDataSource {
  TasksDataSource({
    required TasksService tasksService,
    required TradersService tradersService,
    required LocalizationDataSource localization,
    required ItemsDao itemsDao,
    required TaskMapper mapper,
  }) : _tasksService = tasksService,
       _tradersService = tradersService,
       _localization = localization,
       _itemsDao = itemsDao,
       _mapper = mapper;

  final TasksService _tasksService;
  final TradersService _tradersService;
  final LocalizationDataSource _localization;
  final ItemsDao _itemsDao;
  final TaskMapper _mapper;

  static const _mode = GameMode.pve;

  Future<Result<List<TaskEntity>>> getRemoteTasks() => safeApiCall(() async {
    final tasksFuture = _tasksService.getTasks(_mode.apiValue);
    final taskLocFuture = _localization.localize(_mode, 'tasks');
    final mapLocFuture = _localization.localize(_mode, 'maps');
    final tradersFuture = _tradersService.getTraders(_mode.apiValue);
    final traderLocFuture = _localization.localize(_mode, 'traders');

    final tasks = (await tasksFuture).data.tasks.values.toList();
    final taskLoc = await taskLocFuture;
    final mapLoc = await mapLocFuture;
    final traders = (await tradersFuture).data;
    final traderLoc = await traderLocFuture;

    final taskNames = _mapper.taskNames(tasks, taskLoc);
    final items = await _itemsDao.getMiniInfoByIds(
      _mapper.collectItemIds(tasks),
    );

    return tasks
        .map(
          (t) => _mapper.mapApi(
            t,
            taskLoc: taskLoc,
            traders: traders,
            traderLoc: traderLoc,
            mapLoc: mapLoc,
            taskNames: taskNames,
            items: items,
          ),
        )
        .toList();
  });
}
