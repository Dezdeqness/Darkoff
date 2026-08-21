import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/presentation/features/item_detail/utils/properties_section_utils.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class PropertiesSection extends StatelessWidget {
  const PropertiesSection({super.key, required this.properties});

  final ItemProperties properties;

  @override
  Widget build(BuildContext context) {
    final rows = PropertiesSectionUtils.getFilteredEntries(properties);
    if (rows.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: PropertiesSectionUtils.getTitle(properties)),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: rows
                  .map((e) => AppInfoRow(label: e.$1, value: e.$2))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
