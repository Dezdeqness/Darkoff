import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search...',
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 0),
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: padding,
      child: Container(
        height: 39,
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.borderStrong),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, right: 10),
              child:
                  Icon(Icons.search, color: colors.textSecondary, size: 17),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                style: typo.bodySmall.copyWith(color: colors.textPrimary),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle:
                      typo.bodySmall.copyWith(color: colors.textSecondary),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: onChanged,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
