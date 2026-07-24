import 'package:darkoff/data/local/database.dart';
import 'package:darkoff/data/models/item_api.dart' show ContainedRefApi;
import 'package:darkoff/data/models/task_api.dart';
import 'package:darkoff/data/models/trader_dump_api.dart';
import 'package:darkoff/domain/entities/item_mini_info.dart';
import 'package:darkoff/domain/entities/task_entity.dart';
import 'package:drift/drift.dart';

class TaskMapper {
  const TaskMapper();

  TaskEntity mapApi(
    TaskApi task, {
    required Map<String, String> taskLoc,
    required Map<String, TraderDumpApi> traders,
    required Map<String, String> traderLoc,
    required Map<String, String> mapLoc,
    required Map<String, String> taskNames,
    required Map<String, ItemMiniInfo> items,
  }) {
    final trader = traders[task.trader];
    final rewards = task.finishRewards;

    return TaskEntity(
      id: task.id,
      name: taskLoc[task.name] ?? task.name ?? task.id,
      traderId: task.trader,
      traderName: traderLoc[trader?.name] ?? trader?.name ?? task.trader ?? '',
      traderNormalizedName: trader?.normalizedName ?? '',
      traderImageLink: trader?.imageLink,
      mapId: task.map,
      mapName: task.map == null
          ? null
          : (mapLoc['${task.map} Name'] ?? task.map),
      kappaRequired: task.kappaRequired ?? false,
      experience: task.experience ?? 0,
      minPlayerLevel: task.minPlayerLevel,
      taskImageLink: task.taskImageLink,
      wikiLink: task.wikiLink,
      objectives: [
        for (final o in task.objectives)
          TaskObjectiveEntity(
            description: taskLoc[o.description] ?? o.description ?? '',
            type: o.type ?? '',
            optional: o.optional ?? false,
          ),
      ],
      prerequisites: [
        for (final r in task.taskRequirements)
          if (r.task != null)
            TaskPrerequisiteEntity(
              taskId: r.task!,
              taskName: taskNames[r.task] ?? r.task!,
            ),
      ],
      rewardItems: [
        for (final i in rewards?.items ?? const []) _rewardItemApi(i, items),
      ],
      rewardStanding: [
        for (final s in rewards?.traderStanding ?? const [])
          TaskRewardStandingEntity(
            traderId: s.trader,
            traderName: _traderName(s.trader, traders, traderLoc),
            standing: s.standing?.toDouble() ?? 0,
          ),
      ],
    );
  }

  TaskRewardItemEntity _rewardItemApi(
    ContainedRefApi i,
    Map<String, ItemMiniInfo> items,
  ) {
    final info = items[i.item];
    return TaskRewardItemEntity(
      id: i.item,
      name: info?.name ?? info?.shortName ?? '',
      shortName: info?.shortName ?? info?.name ?? '',
      iconLink: info?.iconLink,
      price: info?.price,
      count: i.count?.toInt() ?? 1,
    );
  }

  String _traderName(
    String? id,
    Map<String, TraderDumpApi> traders,
    Map<String, String> traderLoc,
  ) {
    final t = traders[id];
    return traderLoc[t?.name] ?? t?.name ?? id ?? '';
  }

  Set<String> collectItemIds(Iterable<TaskApi> tasks) {
    final ids = <String>{};
    for (final t in tasks) {
      for (final i in t.finishRewards?.items ?? const []) {
        ids.add(i.item);
      }
    }
    return ids;
  }

  Map<String, String> taskNames(
    Iterable<TaskApi> tasks,
    Map<String, String> taskLoc,
  ) => {for (final t in tasks) t.id: taskLoc[t.name] ?? t.name ?? t.id};

  TasksCompanion toTaskCompanion(TaskEntity task) => TasksCompanion.insert(
    id: task.id,
    name: task.name,
    traderId: Value(task.traderId),
    mapId: Value(task.mapId),
    kappaRequired: Value(task.kappaRequired),
    experience: Value(task.experience),
    minPlayerLevel: Value(task.minPlayerLevel),
    taskImageLink: Value(task.taskImageLink),
    wikiLink: Value(task.wikiLink),
  );

  TaskObjectivesCompanion toObjectiveCompanion(
    String taskId,
    TaskObjectiveEntity objective,
  ) => TaskObjectivesCompanion.insert(
    taskId: taskId,
    description: objective.description,
    type: objective.type,
    optional: Value(objective.optional),
  );

  TaskPrerequisitesCompanion toPrerequisiteCompanion(
    String taskId,
    TaskPrerequisiteEntity prerequisite,
  ) => TaskPrerequisitesCompanion.insert(
    taskId: taskId,
    prerequisiteTaskId: prerequisite.taskId,
  );

  TaskRewardItemsCompanion toRewardItemCompanion(
    String taskId,
    TaskRewardItemEntity reward,
  ) => TaskRewardItemsCompanion.insert(
    taskId: taskId,
    itemId: reward.id,
    count: Value(reward.count),
  );

  TaskRewardStandingsCompanion toRewardStandingCompanion(
    String taskId,
    TaskRewardStandingEntity standing,
  ) => TaskRewardStandingsCompanion.insert(
    taskId: taskId,
    traderId: Value(standing.traderId),
    standing: standing.standing,
  );

  TaskEntity toTaskEntity(
    Task row, {
    required List<TaskObjective> objectives,
    required List<TaskPrerequisite> prerequisites,
    required List<TaskRewardItem> rewardItems,
    required List<TaskRewardStanding> rewardStanding,
    Trader? trader,
    String? mapName,
    required Map<String, ItemMiniInfo> itemInfo,
    required Map<String, String> taskNames,
    required Map<String, Trader> traders,
  }) {
    return TaskEntity(
      id: row.id,
      name: row.name,
      traderId: row.traderId,
      traderName: trader?.name ?? row.traderId ?? '',
      traderNormalizedName: trader?.normalizedName ?? '',
      traderImageLink: trader?.imageLink,
      mapId: row.mapId,
      mapName: mapName,
      kappaRequired: row.kappaRequired,
      experience: row.experience,
      minPlayerLevel: row.minPlayerLevel,
      taskImageLink: row.taskImageLink,
      wikiLink: row.wikiLink,
      objectives: objectives
          .map(
            (o) => TaskObjectiveEntity(
              description: o.description,
              type: o.type,
              optional: o.optional,
            ),
          )
          .toList(),
      prerequisites: prerequisites
          .map(
            (p) => TaskPrerequisiteEntity(
              taskId: p.prerequisiteTaskId,
              taskName: taskNames[p.prerequisiteTaskId] ?? p.prerequisiteTaskId,
            ),
          )
          .toList(),
      rewardItems: rewardItems.map((r) {
        final info = itemInfo[r.itemId];
        return TaskRewardItemEntity(
          id: r.itemId,
          name: info?.name ?? info?.shortName ?? '',
          shortName: info?.shortName ?? info?.name ?? '',
          iconLink: info?.iconLink,
          price: info?.price,
          count: r.count,
        );
      }).toList(),
      rewardStanding: rewardStanding.map((s) {
        final t = s.traderId == null ? null : traders[s.traderId];
        return TaskRewardStandingEntity(
          traderId: s.traderId,
          traderName: t?.name ?? s.traderId ?? '',
          standing: s.standing,
        );
      }).toList(),
    );
  }
}
