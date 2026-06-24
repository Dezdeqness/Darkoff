import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/widgets/app_section_header.dart';
import 'package:darkoff/presentation/features/ammo/ammo_chart_keys.dart';
import 'package:darkoff/presentation/features/ammo/model/ammo_chart_ui_model.dart';
import 'package:darkoff/presentation/features/ammo/notifiers/ammo_chart_notifier.dart';
import 'package:darkoff/presentation/features/ammo/state/ammo_chart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AmmoChart extends ConsumerWidget {
  const AmmoChart({
    super.key,
    required this.caliber,
    required this.currentItemId,
  });

  final String caliber;
  final String currentItemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(
      ammoChartProvider(
        caliber: caliber,
        currentItemId: currentItemId,
      ),
    );

    final child = state.when(
      initial: () => buildLoading(context: context),
      loading: () => buildLoading(context: context),
      loaded: (chart) => chart.rows.isEmpty
          ? const SizedBox.shrink(key: AmmoChartKeys.empty)
          : buildContent(context: context, chart: chart),
      error: (_) => const SizedBox.shrink(key: AmmoChartKeys.error),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: child,
    );
  }

  Widget buildLoading({required BuildContext context}) {
    final colors = context.colorTheme;
    final shape = context.shapeTheme;

    return Column(
      key: AmmoChartKeys.loading,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: 'Ammo Chart'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.border),
              borderRadius: shape.radiusMD,
            ),
            child: Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: colors.gold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildContent({
    required BuildContext context,
    required AmmoChartUiModel chart,
  }) {
    final colors = context.colorTheme;
    final shape = context.shapeTheme;

    return Column(
      key: AmmoChartKeys.content,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: 'Ammo Chart'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.border),
              borderRadius: shape.radiusMD,
            ),
            child: Column(
              children: [
                buildHeaderRow(context: context),
                ...chart.rows.asMap().entries.map((e) {
                  return buildRow(
                    context: context,
                    row: e.value,
                    showDivider: e.key < chart.rows.length - 1,
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildHeaderRow({required BuildContext context}) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final style = typo.labelSmall.copyWith(color: colors.textTertiary);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Expanded(
            flex: 3,
            child: Text('NAME', style: style),
          ),
          SizedBox(
            width: 40,
            child: Text('DMG', style: style, textAlign: TextAlign.center),
          ),
          SizedBox(
            width: 40,
            child: Text('PEN', style: style, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  Widget buildRow({
    required BuildContext context,
    required AmmoChartRowUiModel row,
    required bool showDivider,
  }) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final nameColor = row.highlighted ? colors.gold : colors.textPrimary;

    return Container(
      decoration: BoxDecoration(
        color: row.highlighted ? colors.gold.withValues(alpha: 0.08) : null,
        border: showDivider
            ? Border(bottom: BorderSide(color: colors.border))
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: row.penColor,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.name,
                  style: typo.labelMedium.copyWith(
                    color: nameColor,
                    fontWeight:
                        row.highlighted ? FontWeight.w700 : FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (row.isTracer)
                  Text(
                    'Tracer',
                    style: typo.paragraphSmall
                        .copyWith(color: colors.textTertiary),
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              row.damage,
              style: typo.labelMedium.copyWith(color: colors.textPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              row.penetration,
              style: typo.labelMedium
                  .copyWith(color: row.penColor, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
