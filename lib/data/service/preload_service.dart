import 'dart:async';

import 'package:darkoff/data/local/dao/items_dao.dart';
import 'package:darkoff/data/local/dao/tasks_dao.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:darkoff/domain/repositories/items_repository.dart';
import 'package:darkoff/domain/repositories/tasks_repository.dart';
import 'package:logger/logger.dart';

const int _batchSize = 3000;
const int _maxRetries = 3;
const Duration _retryDelay = Duration(seconds: 2);
const Duration _requestTimeout = Duration(seconds: 60);

class PreloadService {
  PreloadService({
    required ItemsRepository repository,
    required ItemsDao dao,
    required TasksRepository tasksRepository,
    required TasksDao tasksDao,
    required Logger logger,
  })  : _repository = repository,
        _dao = dao,
        _tasksRepository = tasksRepository,
        _tasksDao = tasksDao,
        _logger = logger;

  final ItemsRepository _repository;
  final ItemsDao _dao;
  final TasksRepository _tasksRepository;
  final TasksDao _tasksDao;
  final Logger _logger;

  Future<bool> hasLocalData() async {
    final itemCount = await _dao.getItemCount();
    final taskCount = await _tasksDao.getTaskCount();
    _logger.i('Local item count: $itemCount, task count: $taskCount');
    return itemCount > 0 && taskCount > 0;
  }

  Stream<int> preloadItems() async* {
    int offset = 0;
    int totalLoaded = 0;
    final allItems = <ItemDetailEntity>[];

    while (true) {
      _logger.i('Fetching batch: offset=$offset, limit=$_batchSize');
      final items = await _fetchWithRetry(offset: offset);

      if (items == null) {
        throw Exception('Failed to fetch items after $_maxRetries retries');
      }

      _logger.i('Received ${items.length} items');

      if (items.isNotEmpty) {
        allItems.addAll(items);
        totalLoaded += items.length;
        _logger.i('Fetched batch, total: $totalLoaded');
        yield totalLoaded;
      }

      if (items.length < _batchSize) {
        break;
      }

      offset += items.length;
    }

    _logger.i('Inserting $totalLoaded items into database...');
    await _dao.insertAllItems(allItems);
    _logger.i('Preload complete: $totalLoaded items loaded');

    _logger.i('Fetching tasks...');
    final tasks = await _fetchTasksWithRetry();
    if (tasks == null) {
      throw Exception('Failed to fetch tasks after $_maxRetries retries');
    }
    _logger.i('Inserting ${tasks.length} tasks into database...');
    await _tasksDao.insertAllTasks(tasks);
    _logger.i('Preload complete: ${tasks.length} tasks loaded');
  }

  Future<List<ItemDetailEntity>?> _fetchWithRetry({required int offset}) async {
    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        _logger.i('Attempt $attempt: fetching offset=$offset');

        final result = await _repository
            .getItems(limit: _batchSize, offset: offset)
            .timeout(_requestTimeout);

        final items = result.fold(
          (items) => items,
          (error) {
            _logger.w('Attempt $attempt: API error: $error');
            return null;
          },
        );

        if (items != null) {
          return items;
        }

        if (attempt < _maxRetries) {
          await Future.delayed(_retryDelay);
        }
      } on TimeoutException {
        _logger.w('Attempt $attempt timed out (offset: $offset)');
        if (attempt < _maxRetries) {
          await Future.delayed(_retryDelay);
        }
      } catch (e) {
        _logger.w('Attempt $attempt error: $e');
        if (attempt < _maxRetries) {
          await Future.delayed(_retryDelay);
        }
      }
    }
    return null;
  }

  Future<List<TaskEntity>?> _fetchTasksWithRetry() async {
    for (int attempt = 1; attempt <= _maxRetries; attempt++) {
      try {
        _logger.i('Attempt $attempt: fetching tasks');

        final result =
            await _tasksRepository.getRemoteTasks().timeout(_requestTimeout);

        final tasks = result.fold(
          (tasks) => tasks,
          (error) {
            _logger.w('Attempt $attempt: tasks API error: $error');
            return null;
          },
        );

        if (tasks != null) {
          return tasks;
        }

        if (attempt < _maxRetries) {
          await Future.delayed(_retryDelay);
        }
      } on TimeoutException {
        _logger.w('Attempt $attempt: tasks fetch timed out');
        if (attempt < _maxRetries) {
          await Future.delayed(_retryDelay);
        }
      } catch (e) {
        _logger.w('Attempt $attempt: tasks error: $e');
        if (attempt < _maxRetries) {
          await Future.delayed(_retryDelay);
        }
      }
    }
    return null;
  }
}
