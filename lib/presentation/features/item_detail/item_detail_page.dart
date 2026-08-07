import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/utils/color_utils.dart';
import 'package:darkoff/core/widgets/app_error_view.dart';
import 'package:darkoff/core/widgets/app_image.dart';
import 'package:darkoff/core/widgets/app_label.dart';
import 'package:darkoff/core/widgets/app_section_header.dart';
import 'package:darkoff/core/widgets/page_header.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';
import 'package:darkoff/presentation/features/ammo/widgets/ammo_chart.dart';
import 'package:darkoff/presentation/features/core/model/property_tile_ui_model.dart';
import 'package:darkoff/presentation/features/item_detail/model/item_detail_ui_model.dart';
import 'package:darkoff/presentation/features/item_detail/notifiers/item_detail_notifier.dart';
import 'package:darkoff/presentation/features/item_detail/state/item_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ItemDetailPage extends ConsumerWidget {
  const ItemDetailPage({super.key, @PathParam('id') required this.itemId});

  final String itemId;

  Widget buildContent({
    required BuildContext context,
    required ItemDetailUiModel item,
  }) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(child: PageHeader(title: '')),
        SliverToBoxAdapter(
          child: buildDetailsHeader(context: context, item: item),
        ),
        SliverToBoxAdapter(
          child: buildPricesSection(context: context, prices: item.prices),
        ),
        if (item.properties.isNotEmpty)
          SliverToBoxAdapter(
            child: buildProperties(
              context: context,
              properties: item.properties,
            ),
          ),
        if (item.itemProperties case AmmoProperties(:final caliber?))
          SliverToBoxAdapter(
            child: AmmoChart(caliber: caliber, currentItemId: item.id),
          ),
        if (item.sellPrices.isNotEmpty)
          SliverToBoxAdapter(
            child: buildSellSection(context: context, prices: item.sellPrices),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 32)),
      ],
    );
  }

  Widget buildDetailsHeader({
    required BuildContext context,
    required ItemDetailUiModel item,
  }) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;
    final itemBackground = parseHexColor(item.backgroundColor);
    final imageUrl = item.imageUrl;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: itemBackground,
              border: Border.all(color: itemBackground.withValues(alpha: 0.6)),
              borderRadius: shape.radiusXL,
            ),
            child: ClipRRect(
              borderRadius: shape.radiusXL,
              child: imageUrl != null
                  ? AppImage(imageUrl: imageUrl, fit: BoxFit.contain)
                  : const SizedBox(),
            ),
          ),
          const SizedBox(height: 16),

          Text(
            item.displayName,
            textAlign: TextAlign.center,
            style: typo.titleMedium.copyWith(color: colors.textPrimary),
          ),
          const SizedBox(height: 4),

          Text(
            item.categoryLabel.isNotEmpty ? item.categoryLabel : tr.items.category.item,
            textAlign: TextAlign.center,
            style: typo.bodySmall.copyWith(color: colors.textSecondary),
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 8.0,
            children: item.labels.map((item) => AppLabel(text: item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildProperties({
    required BuildContext context,
    required List<PropertyTileUiModel> properties,
  }) {
    if (properties.isEmpty) {
      return const SizedBox();
    }

    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: tr.itemDetail.section.properties),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.5,
            children: properties.map((item) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: colors.surface,
                  border: Border.all(color: colors.border),
                  borderRadius: shape.radiusMD,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.label,
                      style: typo.paragraphSmall.copyWith(
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.value,
                      style: typo.labelLarge.copyWith(
                        color: propertyColor(item.type, colors),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildPricesSection({
    required BuildContext context,
    required List<PriceRowUiModel> prices,
  }) {
    final colors = context.colorTheme;
    final shape = context.shapeTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: tr.itemDetail.section.prices),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: colors.surface,
              border: Border.all(color: colors.border),
              borderRadius: shape.radiusMD,
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              children: List.generate(prices.length, (index) {
                final item = prices[index];
                return Column(
                  children: [
                    buildPriceRow(context: context, item: item),
                    if (index != prices.length - 1)
                      Divider(color: colors.border),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPriceRow({
    required BuildContext context,
    required final PriceRowUiModel item,
  }) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.label,
                style: typo.paragraphSmall.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.price,
                style: typo.bodyLarge.copyWith(
                  color: item.highlight ? colors.gold : colors.textPrimary,
                  fontWeight: item.highlight
                      ? FontWeight.w700
                      : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (item.badge != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: item.positiveBadge
                  ? colors.profitSubtle
                  : colors.lossSubtle,
              borderRadius: shape.radiusXS,
            ),
            child: Text(
              item.badge!,
              style: typo.labelSmall.copyWith(
                color: item.positiveBadge ? colors.profit : colors.loss,
              ),
            ),
          ),
      ],
    );
  }

  Widget buildSellSection({
    required BuildContext context,
    required List<SellPriceUiModel> prices,
  }) {
    final colors = context.colorTheme;
    final typo = context.typographyTheme;
    final shape = context.shapeTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: tr.itemDetail.section.sellTo),

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
                for (int index = 0; index < prices.length; index++) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            prices[index].vendor,
                            style: typo.paragraphMedium.copyWith(
                              color: colors.gold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          prices[index].price,
                          style: typo.bodyMedium.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (index != prices.length - 1)
                    Divider(height: 1, color: colors.border),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.colorTheme;
    final state = ref.watch(itemDetailProvider(itemId));

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: state.when(
          initial: () =>
              Center(child: CircularProgressIndicator(color: colors.gold)),
          loading: () =>
              Center(child: CircularProgressIndicator(color: colors.gold)),
          loaded: (item) => buildContent(context: context, item: item),
          error: (message) => AppErrorView(
            message: message,
            onRetry: () =>
                ref.read(itemDetailProvider(itemId).notifier).retry(),
          ),
        ),
      ),
    );
  }
}
