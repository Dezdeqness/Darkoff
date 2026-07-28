import 'package:darkoff/core/widgets/app_filter_chip.dart';
import 'package:darkoff/presentation/features/crafts/model/crafts_list_ui_model.dart';
import 'package:flutter/material.dart';

class CraftStationFilter extends StatelessWidget {
  const CraftStationFilter({
    super.key,
    required this.stations,
    required this.onSelected,
  });

  final List<CraftStationOption> stations;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: 40,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: stations.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final station = stations[i];
            return AppFilterChip(
              label: station.label,
              isActive: station.active,
              onTap: () => onSelected(station.value),
            );
          },
        ),
      ),
    );
  }
}
