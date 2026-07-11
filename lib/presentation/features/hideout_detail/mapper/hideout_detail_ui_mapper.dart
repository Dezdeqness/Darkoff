import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/domain/entities/hideout_entity.dart';
import 'package:darkoff/domain/entities/hideout_progress_entity.dart';
import 'package:darkoff/presentation/features/hideout/utils/hideout_progress_utils.dart';
import 'package:darkoff/presentation/features/hideout_detail/model/hideout_detail_ui_model.dart';

class HideoutDetailUiMapper {
  HideoutDetailUiModel fromEntity(
    HideoutStationEntity station,
    HideoutProgressEntity progress,
  ) {
    final nextUpIndex = station.levels.indexWhere(
      (level) => !progress.builtLevels
          .contains(HideoutProgressEntity.levelKey(station.id, level.level)),
    );
    final fullyBuilt = nextUpIndex == -1;
    final lastIndex = station.levels.length - 1;

    HideoutLevelStatus statusOf(int index) {
      if (fullyBuilt || index < nextUpIndex) return HideoutLevelStatus.built;
      if (index == nextUpIndex) return HideoutLevelStatus.nextUp;
      return HideoutLevelStatus.locked;
    }

    return HideoutDetailUiModel(
      stationId: station.id,
      name: station.name,
      imageLink: station.imageLink,
      tracked: progress.trackedStations.contains(station.id),
      fullyBuilt: fullyBuilt,
      levels: [
        for (var i = 0; i < station.levels.length; i++)
          _levelCard(
            station: station,
            level: station.levels[i],
            status: statusOf(i),
            defaultExpanded: statusOf(i) == HideoutLevelStatus.nextUp ||
                (fullyBuilt && i == lastIndex),
            progress: progress,
          ),
      ],
    );
  }

  LevelCardUiModel _levelCard({
    required HideoutStationEntity station,
    required HideoutLevelEntity level,
    required HideoutLevelStatus status,
    required bool defaultExpanded,
    required HideoutProgressEntity progress,
  }) {
    final cost = level.itemRequirements
        .fold(0, (s, r) => s + (r.price ?? 1) * r.count);
    final readOnly = status == HideoutLevelStatus.built;

    int owned(HideoutItemReqEntity req) =>
        progress.ownedCounts[HideoutProgressEntity.itemKey(
            station.id, level.level, req.id)] ??
        0;

    final itemReqs = level.itemRequirements
        .where((r) => !hideoutCurrencyItemIds.contains(r.id))
        .toList();
    final currencyReqs = level.itemRequirements
        .where((r) => hideoutCurrencyItemIds.contains(r.id))
        .toList();

    final complete = itemReqs.where((r) => owned(r) >= r.count).length;

    final hasPrereqs = level.stationRequirements.isNotEmpty ||
        level.traderRequirements.isNotEmpty;
    final allStationPrereqsMet = level.stationRequirements.isNotEmpty &&
        level.stationRequirements.every((r) => progress.builtLevels
            .contains(HideoutProgressEntity.levelKey(r.stationId, r.level)));

    return LevelCardUiModel(
      level: level.level,
      title: 'Level ${level.level}',
      status: status,
      defaultExpanded: defaultExpanded,
      readOnly: readOnly,
      timeText: status == HideoutLevelStatus.nextUp
          ? _formatDuration(level.constructionTime)
          : null,
      costText: status == HideoutLevelStatus.nextUp && cost > 0
          ? '${formatCompactPrice(cost)} ₽'
          : null,
      collapsedSummaryText: status == HideoutLevelStatus.nextUp
          ? null
          : '${itemReqs.length} items · ${formatCompactPrice(cost)} ₽',
      lockedMessage: status == HideoutLevelStatus.locked
          ? 'Complete Level ${level.level - 1} to unlock'
          : null,
      prereqLabel: hasPrereqs
          ? (allStationPrereqsMet
              ? 'PREREQUISITES · ALL MET'
              : 'PREREQUISITES')
          : null,
      prereqs: [
        ...level.stationRequirements.map(
          (r) => PrereqRowUiModel(
            label: '${r.stationName} Level ${r.level}',
            met: progress.builtLevels.contains(
                HideoutProgressEntity.levelKey(r.stationId, r.level)),
          ),
        ),
        ...level.traderRequirements.map(
          (r) => PrereqRowUiModel(
            label: '${r.traderName} LL${r.loyaltyLevel ?? '?'}',
            isTrader: true,
          ),
        ),
      ],
      resourcesLabel: itemReqs.isEmpty
          ? null
          : readOnly
              ? 'WAS REQUIRED'
              : 'RESOURCES · $complete / ${itemReqs.length} COMPLETE',
      items: [
        for (final req in itemReqs)
          ItemReqRowUiModel(
            itemId: req.id,
            shortName: req.shortName,
            iconLink: req.iconLink,
            subtitle: _itemSubtitle(req, owned(req)),
            met: owned(req) >= req.count,
            owned: owned(req),
            maxCount: req.count,
            countText: '× ${req.count}',
          ),
      ],
      currencies: [
        for (final req in currencyReqs)
          MoneyReqRowUiModel(
            itemId: req.id,
            symbol: hideoutCurrencySymbol(req.id),
            name: req.shortName,
            subtitle: _moneySubtitle(req, owned(req)),
            met: owned(req) >= req.count,
            owned: owned(req),
            requiredCount: req.count,
            requiredText: formatPrice(req.count),
          ),
      ],
      bonuses: level.bonuses.map(_formatBonus).toList(),
    );
  }

  String _itemSubtitle(HideoutItemReqEntity req, int owned) {
    if (owned >= req.count) return '✓ Requirement met';
    final missing = req.count - owned;
    if (req.price != null) {
      return '${formatPrice(req.price!)} ₽ each · need $missing more';
    }
    return 'need $missing more';
  }

  String _moneySubtitle(HideoutItemReqEntity req, int owned) {
    final missing = (req.count - owned).clamp(0, req.count);
    if (missing == 0) return '✓ Requirement met';
    return '${formatPrice(req.count)} required · ${formatPrice(missing)} to go';
  }

  String _formatDuration(int seconds) {
    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;
    if (h > 0 && m > 0) return '${h}h ${m}m';
    if (h > 0) return '${h}h';
    if (m > 0) return '${m}m';
    return '$seconds s';
  }

  String _formatBonus(HideoutBonusEntity bonus) {
    if (bonus.value == null) return bonus.name;
    final v = bonus.value!;
    final formatted =
        v == v.truncateToDouble() ? '${v.toInt()}' : v.toStringAsFixed(1);
    return '${bonus.name}: +$formatted%';
  }
}
