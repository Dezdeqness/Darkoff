import 'package:ui_kit/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppLabel extends StatelessWidget {
  const AppLabel({required this.text, super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colors.goldSubtle,
        borderRadius: shape.radiusXS,
      ),
      child: Text(
        text,
        style: typo.labelSmall.copyWith(
          color: colors.gold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
