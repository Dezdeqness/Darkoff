import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/item_icon.dart';
import 'package:flutter/material.dart';

class RecipeItemRow extends StatelessWidget {
  const RecipeItemRow({
    super.key,
    required this.iconLink,
    required this.label,
    this.emphasize = false,
  });

  final String? iconLink;
  final String label;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          ItemIcon(
            imageUrl: iconLink,
            size: 26,
            fallbackIcon: Icons.inventory_2_outlined,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: typo.paragraphSmall.copyWith(
                color: emphasize ? colors.gold : colors.textSecondary,
                fontWeight: emphasize ? FontWeight.w600 : FontWeight.w400,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
