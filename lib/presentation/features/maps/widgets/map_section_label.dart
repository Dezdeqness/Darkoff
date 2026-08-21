import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class MapSectionLabel extends StatelessWidget {
  const MapSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: context.typographyTheme.labelMedium.copyWith(
        color: context.colorTheme.gold,
        letterSpacing: 2,
      ),
    );
  }
}
