import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class ItemIcon extends StatelessWidget {
  const ItemIcon({
    super.key,
    this.imageUrl,
    this.fallbackIcon = Icons.inventory_2_outlined,
    this.size = 40,
    this.iconSize,
    this.fit = BoxFit.contain,
    this.useGoldBackground = false,
  });

  final String? imageUrl;
  final IconData fallbackIcon;
  final double size;

  final double? iconSize;
  final BoxFit fit;

  final bool useGoldBackground;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final bg =
        useGoldBackground ? colors.goldSubtle : colors.background;
    final icon = iconSize ?? size * 0.4;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                imageUrl!,
                fit: fit,
                errorBuilder: (ctx, e, st) => Center(
                  child: Icon(fallbackIcon,
                      color: colors.textTertiary, size: icon),
                ),
              ),
            )
          : Center(
              child: Icon(fallbackIcon,
                  color: colors.textTertiary, size: icon),
            ),
    );
  }
}
