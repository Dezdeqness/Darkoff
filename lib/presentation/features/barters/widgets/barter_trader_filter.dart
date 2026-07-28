import 'package:darkoff/core/widgets/app_filter_chip.dart';
import 'package:darkoff/presentation/features/barters/model/barters_list_ui_model.dart';
import 'package:flutter/material.dart';

class BarterTraderFilter extends StatelessWidget {
  const BarterTraderFilter({
    super.key,
    required this.traders,
    required this.onSelected,
  });

  final List<BarterTraderOption> traders;
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
          itemCount: traders.length,
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, i) {
            final trader = traders[i];
            return AppFilterChip(
              label: trader.label,
              isActive: trader.active,
              onTap: () => onSelected(trader.value),
            );
          },
        ),
      ),
    );
  }
}
