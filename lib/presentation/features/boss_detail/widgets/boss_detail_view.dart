import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/widgets/app_section_header.dart';
import 'package:darkoff/presentation/features/boss_detail/model/boss_detail_ui_model.dart';
import 'package:darkoff/presentation/features/boss_detail/model/boss_loot_ui_model.dart';
import 'package:darkoff/presentation/features/boss_detail/notifiers/boss_loot_notifier.dart';
import 'package:darkoff/presentation/features/boss_detail/widgets/boss_health_grid.dart';
import 'package:darkoff/presentation/features/boss_detail/widgets/boss_loot_row.dart';
import 'package:darkoff/presentation/features/boss_detail/widgets/boss_poster.dart';
import 'package:darkoff/presentation/features/boss_detail/widgets/boss_spawn_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BossDetailView extends ConsumerWidget {
  const BossDetailView({super.key, required this.model, required this.bossId});
  final BossDetailUiModel model;
  final String bossId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loot = ref.watch(bossLootProvider(bossId));

    return CustomScrollView(
      slivers: [
        if (model.posterUrl != null)
          SliverToBoxAdapter(child: BossPoster(url: model.posterUrl!)),
        if (model.bodyParts.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: AppSectionHeader(title: tr.bossDetail.section.health),
          ),
          SliverToBoxAdapter(child: BossHealthGrid(parts: model.bodyParts)),
        ],
        if (model.spawns.isNotEmpty) ...[
          SliverToBoxAdapter(
            child: AppSectionHeader(
              title: tr.bossDetail.section.spawnLocations,
            ),
          ),
          SliverList.builder(
            itemCount: model.spawns.length,
            itemBuilder: (ctx, i) => Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                0,
                16,
                i == model.spawns.length - 1 ? 0 : 12,
              ),
              child: BossSpawnCard(spawn: model.spawns[i]),
            ),
          ),
        ],
        ..._buildLootSlivers(loot),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  List<Widget> _buildLootSlivers(AsyncValue<List<BossLootUiModel>> loot) {
    return loot.when(
      loading: () => [
        SliverToBoxAdapter(
          child: AppSectionHeader(title: tr.bossDetail.section.loot),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
      error: (_, __) => const [],
      data: (items) {
        if (items.isEmpty) return const [];
        return [
          SliverToBoxAdapter(
            child: AppSectionHeader(title: tr.bossDetail.section.loot),
          ),
          SliverList.builder(
            itemCount: items.length,
            itemBuilder: (ctx, i) => Padding(
              padding: EdgeInsets.fromLTRB(
                16,
                0,
                16,
                i == items.length - 1 ? 0 : 8,
              ),
              child: BossLootRow(item: items[i]),
            ),
          ),
        ];
      },
    );
  }
}
