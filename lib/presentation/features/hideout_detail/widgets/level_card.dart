import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/presentation/features/hideout/notifiers/hideout_progress_notifier.dart';
import 'package:darkoff/presentation/features/hideout_detail/model/hideout_detail_ui_model.dart';
import 'package:darkoff/presentation/features/hideout_detail/widgets/level_card_body.dart';
import 'package:darkoff/presentation/features/hideout_detail/widgets/level_card_header.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LevelCard extends ConsumerStatefulWidget {
  const LevelCard({
    super.key,
    required this.stationId,
    required this.model,
  });

  final String stationId;
  final LevelCardUiModel model;

  @override
  ConsumerState<LevelCard> createState() => _LevelCardState();
}

class _LevelCardState extends ConsumerState<LevelCard> {
  bool? _expandedOverride;

  bool get _expanded => _expandedOverride ?? widget.model.defaultExpanded;

  @override
  void didUpdateWidget(covariant LevelCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.model.status != widget.model.status ||
        oldWidget.model.defaultExpanded != widget.model.defaultExpanded) {
      _expandedOverride = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    final locked = model.status == HideoutLevelStatus.locked;

    return Opacity(
      opacity: locked ? 0.55 : 1,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LevelCardHeader(
              model: model,
              expanded: _expanded,
              onToggle: () =>
                  setState(() => _expandedOverride = !_expanded),
            ),
            if (_expanded)
              Padding(
                padding: const EdgeInsets.all(14),
                child: locked
                    ? LevelLockedBody(
                        message:
                            model.lockedMessage ?? tr.hideoutDetail.badge.locked,
                      )
                    : LevelCardBody(
                        stationId: widget.stationId,
                        model: model,
                        onSetOwned: _setOwned,
                        onToggleBuilt: _toggleBuilt,
                      ),
              ),
          ],
        ),
      ),
    );
  }

  void _setOwned(String itemId, int count, int maxCount) {
    ref.read(hideoutProgressProvider.notifier).setOwnedCount(
          stationId: widget.stationId,
          level: widget.model.level,
          itemId: itemId,
          count: count,
          maxCount: maxCount,
        );
  }

  void _toggleBuilt() {
    ref.read(hideoutProgressProvider.notifier).toggleBuilt(
          stationId: widget.stationId,
          level: widget.model.level,
        );
  }
}
