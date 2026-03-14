import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/utils/color_utils.dart';
import 'package:darkoff/core/utils/price_utils.dart';
import 'package:darkoff/core/widgets/app_error_view.dart';
import 'package:darkoff/core/widgets/app_image.dart';
import 'package:darkoff/core/widgets/app_info_row.dart';
import 'package:darkoff/core/widgets/app_section_header.dart';
import 'package:darkoff/presentation/features/item_detail/model/item_detail_ui_model.dart';
import 'package:darkoff/presentation/features/item_detail/notifiers/item_detail_notifier.dart';
import 'package:darkoff/presentation/features/item_detail/state/item_detail_state.dart';
import 'package:darkoff/presentation/features/item_detail/widgets/properties_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@RoutePage()
class ItemDetailPage extends ConsumerWidget {
  const ItemDetailPage({super.key, @PathParam('id') required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(itemDetailProvider(itemId));

    return Scaffold(
      body: state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (item) => _buildContent(context, item),
        error: (message) => AppErrorView(
          message: message,
          onRetry: () =>
              ref.read(itemDetailProvider(itemId).notifier).retry(),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ItemDetailUiModel item) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 250,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              item.shortName ?? item.displayName,
              style: const TextStyle(fontSize: 16),
            ),
            background: Container(
              color: parseHexColor(item.backgroundColor),
              child: item.imageUrl != null
                  ? Padding(
                      padding: const EdgeInsets.all(32),
                      child: AppImage(
                        imageUrl: item.imageUrl!,
                        fit: BoxFit.contain,
                      ),
                    )
                  : null,
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoSection(item),
              if (item.description != null && item.description!.isNotEmpty)
                _buildDescriptionSection(context, item.description!),
              if (item.properties != null)
                PropertiesSection(properties: item.properties!),
              if (item.buyFor.isNotEmpty)
                _buildPriceSection('Buy From', item.buyFor),
              if (item.sellFor.isNotEmpty)
                _buildPriceSection('Sell To', item.sellFor),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(ItemDetailUiModel item) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            AppInfoRow(
              label: 'Name',
              value: item.displayName,
            ),
            if (item.categoryLabel.isNotEmpty)
              AppInfoRow(
                label: 'Category',
                value: item.categoryLabel,
              ),
            AppInfoRow(
              label: 'Base Price',
              value: '${formatPrice(item.basePrice)} \u20BD',
            ),
            if (item.avg24hPrice != null)
              AppInfoRow(
                label: 'Avg 24h Price',
                value: '${formatPrice(item.avg24hPrice!)} \u20BD',
              ),
            if (item.low24hPrice != null && item.high24hPrice != null)
              AppInfoRow(
                label: '24h Range',
                value:
                    '${formatPrice(item.low24hPrice!)} - ${formatPrice(item.high24hPrice!)} \u20BD',
              ),
            if (item.changeLast48hPercent != null)
              AppInfoRow(
                label: '48h Change',
                value: '${item.changeLast48hPercent! >= 0 ? '+' : ''}${item.changeLast48hPercent!.toStringAsFixed(1)}%',
                valueColor: item.changeLast48hPercent! >= 0
                    ? Colors.green
                    : Colors.red,
              ),
            if (item.width != null && item.height != null)
              AppInfoRow(
                label: 'Size',
                value: '${item.width}x${item.height}',
              ),
            if (item.weight != null)
              AppInfoRow(
                label: 'Weight',
                value: '${item.weight!.toStringAsFixed(2)} kg',
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppSectionHeader(title: 'Description'),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceSection(String title, List<PriceUiModel> prices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSectionHeader(title: title),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: prices
                  .map(
                    (p) => AppInfoRow(
                      label: p.sourceName,
                      value:
                          '${formatPrice(p.price)} ${currencySymbol(p.currency)}',
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
