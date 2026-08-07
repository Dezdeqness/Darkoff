import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/presentation/features/maps/model/map_ui_model.dart';
import 'package:darkoff/presentation/features/maps/widgets/map_boss_spawn_row.dart';
import 'package:darkoff/presentation/features/maps/widgets/map_enemy_chip.dart';
import 'package:darkoff/presentation/features/maps/widgets/map_loot_section.dart';
import 'package:darkoff/presentation/features/maps/widgets/map_section_label.dart';
import 'package:darkoff/presentation/features/maps/widgets/map_stat_tile.dart';
import 'package:flutter/material.dart';

class MapDetailView extends StatelessWidget {
  const MapDetailView({super.key, required this.map});

  final MapUiModel map;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (map.description != null && map.description!.isNotEmpty) ...[
            Text(
              map.description!,
              style: context.typographyTheme.paragraphSmall.copyWith(
                color: context.colorTheme.textSecondary,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],

          Row(
            children: [
              MapStatTile(
                icon: Icons.people_outline,
                label: tr.maps.info.players,
                value: map.playersLabel,
              ),
              const SizedBox(width: 10),
              MapStatTile(
                icon: Icons.timer_outlined,
                label: tr.maps.info.duration,
                value: map.durationLabel,
              ),
            ],
          ),

          if (map.enemies.isNotEmpty) ...[
            const SizedBox(height: 24),
            MapSectionLabel(tr.maps.section.enemies),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [for (final e in map.enemies) MapEnemyChip(name: e)],
            ),
          ],

          if (map.bosses.isNotEmpty) ...[
            const SizedBox(height: 24),
            MapSectionLabel(tr.maps.section.bosses),
            const SizedBox(height: 10),
            for (final boss in map.bosses) MapBossSpawnRow(boss: boss),
          ],

          MapLootSection(mapId: map.id),
        ],
      ),
    );
  }
}
