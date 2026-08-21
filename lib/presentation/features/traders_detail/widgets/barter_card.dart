import 'package:darkoff/presentation/features/traders_detail/model/trader_detail_ui_model.dart';
import 'package:darkoff/presentation/features/traders_detail/widgets/trader_item_thumb.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class BarterCard extends StatelessWidget {
  const BarterCard({super.key, required this.barter, required this.onOpenItem});

  final TraderBarterUiModel barter;
  final void Function(String itemId) onOpenItem;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return AppCard(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: colors.goldSubtle,
              borderRadius: shape.radiusXS,
            ),
            child: Text(
              'LL${barter.level}',
              style: typo.labelSmall.copyWith(color: colors.gold),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _thumbs(barter.requiredItems)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward,
                    color: colors.textTertiary, size: 18),
              ),
              Expanded(child: _thumbs(barter.rewardItems)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _thumbs(List<TradeItemUiModel> items) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final item in items)
          TraderItemThumb(item: item, onTap: () => onOpenItem(item.itemId)),
      ],
    );
  }
}
