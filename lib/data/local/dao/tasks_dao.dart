import 'package:darkoff/data/local/dao/task_db_mapper.dart';
import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:drift/drift.dart';

class TasksDao {
  TasksDao({required AppDatabase db, required TaskDbMapper mapper})
      : _db = db,
        _mapper = mapper;

  final AppDatabase _db;
  final TaskDbMapper _mapper;

  Future<int> getTaskCount() async {
    final count = _db.tasks.id.count();
    final query = _db.selectOnly(_db.tasks)..addColumns([count]);
    final row = await query.getSingle();
    return row.read(count) ?? 0;
  }

  Future<void> insertAllTasks(List<TaskEntity> tasks) async {
    await _db.transaction(() async {
      await clearAll();
      await _db.batch((b) {
        for (final task in tasks) {
          b.insert(
            _db.tasks,
            _mapper.toTaskCompanion(task),
            mode: InsertMode.insertOrReplace,
          );
          for (final o in task.objectives) {
            b.insert(_db.taskObjectives, _mapper.toObjectiveCompanion(task.id, o));
          }
          for (final p in task.prerequisites) {
            b.insert(
              _db.taskPrerequisites,
              _mapper.toPrerequisiteCompanion(task.id, p),
            );
          }
          for (final r in task.rewardItems) {
            b.insert(
              _db.taskRewardItems,
              _mapper.toRewardItemCompanion(task.id, r),
            );
          }
          for (final s in task.rewardStanding) {
            b.insert(
              _db.taskRewardStandings,
              _mapper.toRewardStandingCompanion(task.id, s),
            );
          }
        }
      });
    });
  }

  Future<List<TaskEntity>> getAllTasks() async {
    final rows = await (_db.select(_db.tasks)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
    return _hydrate(rows);
  }

  Future<List<TaskEntity>> getTasksByTrader(
    String traderNormalizedName,
  ) async {
    if (traderNormalizedName.isEmpty) return getAllTasks();

    final rows = await (_db.select(_db.tasks)
          ..where((t) => t.traderNormalizedName.equals(traderNormalizedName))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
    return _hydrate(rows);
  }

  Future<List<TaskEntity>> searchTasks({required String query}) async {
    final normalizedQuery = query.trim().toLowerCase();
    if (normalizedQuery.isEmpty) return [];

    final nameRows = await (_db.select(_db.tasks)
          ..where((t) => t.name.like('%$normalizedQuery%')))
        .get();

    final objectiveRows = await (_db.select(_db.taskObjectives)
          ..where((o) => o.description.like('%$normalizedQuery%')))
        .get();

    final haveIds = nameRows.map((t) => t.id).toSet();
    final missingIds =
        objectiveRows.map((o) => o.taskId).toSet().difference(haveIds).toList();

    final extraRows = missingIds.isEmpty
        ? <Task>[]
        : await (_db.select(_db.tasks)..where((t) => t.id.isIn(missingIds)))
            .get();

    final all = [...nameRows, ...extraRows]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return _hydrate(all);
  }

  Future<void> clearAll() async {
    await _db.delete(_db.taskObjectives).go();
    await _db.delete(_db.taskPrerequisites).go();
    await _db.delete(_db.taskRewardItems).go();
    await _db.delete(_db.taskRewardStandings).go();
    await _db.delete(_db.tasks).go();
  }

  Future<List<TaskEntity>> _hydrate(List<Task> taskRows) async {
    if (taskRows.isEmpty) return [];
    final ids = taskRows.map((t) => t.id).toList();

    final objectives = await (_db.select(_db.taskObjectives)
          ..where((t) => t.taskId.isIn(ids)))
        .get();
    final prerequisites = await (_db.select(_db.taskPrerequisites)
          ..where((t) => t.taskId.isIn(ids)))
        .get();
    final rewardItems = await (_db.select(_db.taskRewardItems)
          ..where((t) => t.taskId.isIn(ids)))
        .get();
    final standings = await (_db.select(_db.taskRewardStandings)
          ..where((t) => t.taskId.isIn(ids)))
        .get();

    final objByTask = <String, List<TaskObjective>>{};
    for (final o in objectives) {
      (objByTask[o.taskId] ??= []).add(o);
    }
    final preByTask = <String, List<TaskPrerequisite>>{};
    for (final p in prerequisites) {
      (preByTask[p.taskId] ??= []).add(p);
    }
    final riByTask = <String, List<TaskRewardItem>>{};
    for (final r in rewardItems) {
      (riByTask[r.taskId] ??= []).add(r);
    }
    final stByTask = <String, List<TaskRewardStanding>>{};
    for (final s in standings) {
      (stByTask[s.taskId] ??= []).add(s);
    }

    return taskRows
        .map(
          (row) => _mapper.toTaskEntity(
            row,
            objectives: objByTask[row.id] ?? const [],
            prerequisites: preByTask[row.id] ?? const [],
            rewardItems: riByTask[row.id] ?? const [],
            rewardStanding: stByTask[row.id] ?? const [],
          ),
        )
        .toList();
  }
}
