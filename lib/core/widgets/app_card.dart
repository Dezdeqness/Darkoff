import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(14),
    this.useMDRadius = true,
    this.clipContent = false,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsets padding;

  final bool useMDRadius;

  final bool clipContent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final shape = context.shapeTheme;
    final radius = useMDRadius ? shape.radiusMD : shape.radiusSM;

    Widget card = Container(
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.border),
        borderRadius: radius,
      ),
      clipBehavior: clipContent ? Clip.antiAlias : Clip.none,
      padding: clipContent ? EdgeInsets.zero : padding,
      child: clipContent
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [child],
            )
          : child,
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
