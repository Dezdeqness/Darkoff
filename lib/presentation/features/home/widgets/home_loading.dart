import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

class HomeLoading extends StatelessWidget {
  const HomeLoading({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    return SizedBox(
      height: height,
      child: Center(
        child: CircularProgressIndicator(strokeWidth: 2, color: colors.gold),
      ),
    );
  }
}
