import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_image.dart';
import 'package:flutter/material.dart';

class BossPoster extends StatelessWidget {
  const BossPoster({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final shape = context.shapeTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: AppImage(
          imageUrl: url,
          fit: BoxFit.cover,
          borderRadius: shape.radiusMD,
          backgroundColor: colors.surface,
          errorWidget: Container(
            color: colors.surface,
            child: Center(
              child: Icon(Icons.shield_outlined, color: colors.gold, size: 40),
            ),
          ),
        ),
      ),
    );
  }
}
