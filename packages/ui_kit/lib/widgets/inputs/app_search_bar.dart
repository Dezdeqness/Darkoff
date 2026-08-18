import 'package:ui_kit/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = 'Search...',
    this.padding = const EdgeInsets.fromLTRB(16, 16, 16, 0),
    this.enabled = true,
    this.readOnlyMode = false,
    this.onTap,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;
  final EdgeInsets padding;
  final bool enabled;
  final bool readOnlyMode;
  final VoidCallback? onTap;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: colors.borderStrong),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Icon(
                  Icons.search,
                  color: colors.textSecondary,
                  size: 16,
                ),
              ),
              Expanded(
                child: TextField(
                  onTap: () => onTap?.call(),
                  enabled: enabled,
                  canRequestFocus: !readOnlyMode,
                  controller: controller,
                  style: typo.bodySmall.copyWith(color: colors.textPrimary),
                  autofocus: autofocus,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: typo.bodySmall.copyWith(
                      color: colors.textSecondary,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (text) => onChanged(text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
