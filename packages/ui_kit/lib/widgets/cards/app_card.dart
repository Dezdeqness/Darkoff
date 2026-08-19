import 'package:ui_kit/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.shape,
    this.clipContent = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final ShapeBorder? shape;
  final bool clipContent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final shapeTheme = context.shapeTheme;
    final radius = shapeTheme.radiusMD;

    Widget card;
    if (shape != null) {
      card = DecoratedBox(
        decoration: ShapeDecoration(
          color: colors.surface,
          shape: shape!,
        ),
        child: Padding(
          padding: clipContent ? EdgeInsets.zero : padding,
          child: child,
        ),
      );
    } else {
      card = Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: radius,
        ),
        clipBehavior: clipContent ? Clip.antiAlias : Clip.none,
        padding: clipContent ? EdgeInsets.zero : padding,
        child: child,
      );
    }

    if (clipContent && shape == null) {
      card = ClipRRect(borderRadius: radius, child: card);
    }

    if (onTap != null) {
      card = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: card,
      );
    }

    return card;
  }
}
