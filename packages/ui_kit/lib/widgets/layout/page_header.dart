import 'package:ui_kit/theme/extension/theme_extensions.dart';
import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = true,
    this.onBack,
    this.trailing,
  }) : subtitleWidget = null;

  const PageHeader.subtitleContent({
    super.key,
    required this.title,
    required Widget subtitle,
    this.showBack = true,
    this.onBack,
    this.trailing,
  })  : subtitleWidget = subtitle,
        subtitle = null;

  final String title;
  final String? subtitle;

  final Widget? subtitleWidget;
  final bool showBack;
  final VoidCallback? onBack;

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;

    final subtitleChild = subtitleWidget ??
        (subtitle != null
            ? Text(
                subtitle!,
                style: typo.bodySmall.copyWith(color: colors.textSecondary),
              )
            : null);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Row(
        children: [
          if (showBack) ...[
            GestureDetector(
              onTap: onBack,
              behavior: HitTestBehavior.opaque,
              child: Icon(
                Icons.arrow_back_ios_new,
                color: colors.textPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: subtitleChild != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: typo.titleLarge.copyWith(
                          color: colors.textPrimary,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      subtitleChild,
                    ],
                  )
                : Text(
                    title,
                    style: typo.titleLarge.copyWith(
                      color: colors.textPrimary,
                      letterSpacing: 0.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 8),
            ?trailing,
          ],
        ],
      ),
    );
  }
}
