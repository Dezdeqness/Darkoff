import 'package:ui_kit/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final radius = borderRadius ?? context.shapeTheme.radiusMD;

    Widget card = ClipRRect(
      borderRadius: radius,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.border),
          borderRadius: radius,
        ),
        clipBehavior: Clip.antiAlias,
        padding: padding,
        child: child,
      ),
    );

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