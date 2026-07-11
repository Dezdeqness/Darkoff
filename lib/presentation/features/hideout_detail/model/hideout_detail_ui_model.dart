import 'package:freezed_annotation/freezed_annotation.dart';

part 'hideout_detail_ui_model.freezed.dart';

enum HideoutLevelStatus { built, nextUp, locked }

@freezed
abstract class PrereqRowUiModel with _$PrereqRowUiModel {
  const factory PrereqRowUiModel({
    required String label,
    @Default(false) bool met,
    @Default(false) bool isTrader,
  }) = _PrereqRowUiModel;
}

@freezed
abstract class ItemReqRowUiModel with _$ItemReqRowUiModel {
  const factory ItemReqRowUiModel({
    required String itemId,
    required String shortName,
    String? iconLink,
    required String subtitle,
    required bool met,
    required int owned,
    required int maxCount,
    required String countText,
  }) = _ItemReqRowUiModel;
}

@freezed
abstract class MoneyReqRowUiModel with _$MoneyReqRowUiModel {
  const factory MoneyReqRowUiModel({
    required String itemId,
    required String symbol,
    required String name,
    required String subtitle,
    required bool met,
    required int owned,
    required int requiredCount,
    required String requiredText,
  }) = _MoneyReqRowUiModel;
}

@freezed
abstract class LevelCardUiModel with _$LevelCardUiModel {
  const factory LevelCardUiModel({
    required int level,
    required String title,
    required HideoutLevelStatus status,
    required bool defaultExpanded,
    required bool readOnly,
    String? timeText,
    String? costText,
    String? collapsedSummaryText,
    String? lockedMessage,
    String? prereqLabel,
    @Default([]) List<PrereqRowUiModel> prereqs,
    String? resourcesLabel,
    @Default([]) List<ItemReqRowUiModel> items,
    @Default([]) List<MoneyReqRowUiModel> currencies,
    @Default([]) List<String> bonuses,
  }) = _LevelCardUiModel;
}

@freezed
abstract class HideoutDetailUiModel with _$HideoutDetailUiModel {
  const factory HideoutDetailUiModel({
    required String stationId,
    required String name,
    String? imageLink,
    required bool tracked,
    required bool fullyBuilt,
    @Default([]) List<LevelCardUiModel> levels,
  }) = _HideoutDetailUiModel;
}
