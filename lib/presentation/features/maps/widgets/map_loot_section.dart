import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/presentation/features/maps/model/map_loot_ui_model.dart';
import 'package:darkoff/presentation/features/maps/notifiers/map_loot_notifier.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MapLootSection extends ConsumerWidget {
  const MapLootSection({super.key, required this.mapId});

  final String mapId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items =
        ref.watch(mapLootProvider(mapId)).asData?.value ??
        const <MapLootUiModel>[];
    if (items.isEmpty) return const SizedBox.shrink();

    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text(
          tr.maps.section.valuableLoot,
          style: typo.labelMedium.copyWith(
            color: colors.gold,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        for (final item in items) _MapLootRow(item: item),
      ],
    );
  }
}

class _MapLootRow extends StatelessWidget {
  const _MapLootRow({required this.item});

  final MapLootUiModel item;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return GestureDetector(
      onTap: () => context.router.push(ItemDetailRoute(itemId: item.id)),
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: shape.radiusMD,
        ),
        child: Row(
          children: [
            ItemIcon(imageUrl: item.iconUrl, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                item.name,
                style: typo.labelMedium.copyWith(color: colors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              item.priceLabel,
              style: typo.labelMedium.copyWith(
                color: colors.gold,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
