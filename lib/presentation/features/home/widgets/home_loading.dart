import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

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
