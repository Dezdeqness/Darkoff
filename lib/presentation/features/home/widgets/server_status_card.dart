import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/theme/themes/color_theme.dart';
import 'package:darkoff/presentation/features/home/model/server_status_ui_model.dart';
import 'package:darkoff/presentation/features/home/state/server_status_state.dart';
import 'package:flutter/material.dart';

class ServerStatusCard extends StatelessWidget {
  const ServerStatusCard({
    super.key,
    required this.state,
    required this.onRefresh,
  });

  final ServerStatusState state;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    final status = state is ServerStatusLoaded
        ? (state as ServerStatusLoaded).status
        : null;
    final isLoading = state is ServerStatusLoading || state is ServerStatusInitial;
    final accent = _accent(colors, status?.level);

    return GestureDetector(
      onTap: onRefresh,
      behavior: HitTestBehavior.opaque,
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          border: Border.all(color: isLoading ? colors.border : accent),
          borderRadius: shape.radiusMD,
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr.serverStatus.label,
                    style: typo.labelMedium.copyWith(
                      color: colors.textSecondary,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isLoading ? tr.serverStatus.checking : (status?.statusLabel ?? tr.common.value.unknown),
                    style: typo.titleSmall.copyWith(
                      color: isLoading ? colors.textSecondary : accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              SizedBox(
                width: 14,
                height: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 1.5,
                  color: colors.textTertiary,
                ),
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.15),
                  borderRadius: shape.radiusXS,
                ),
                child: Text(
                  status?.badgeLabel ?? tr.common.value.unknownUpper,
                  style: typo.labelSmall.copyWith(
                    color: accent,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Color _accent(ColorTheme colors, ServerStatusLevel? level) {
    return switch (level) {
      ServerStatusLevel.operational => colors.profit,
      ServerStatusLevel.updating ||
      ServerStatusLevel.unstable =>
        colors.gold,
      ServerStatusLevel.offline => colors.loss,
      _ => colors.textTertiary,
    };
  }
}
