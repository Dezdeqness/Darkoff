import 'package:ui_kit/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel(
    this.text, {
    super.key,
    this.padding = const EdgeInsets.fromLTRB(16, 20, 16, 8),
    this.letterSpacing = 2.0,
  });

  final String text;
  final EdgeInsets padding;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: padding,
      child: Text(
        text.toUpperCase(),
        style: typo.labelMedium.copyWith(
          color: colors.gold,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}
