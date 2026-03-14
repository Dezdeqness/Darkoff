import 'package:auto_route/auto_route.dart';
import 'package:darkoff/core/navigation/app_router.gr.dart';
import 'package:darkoff/core/theme/extension/theme_extensions.dart';
import 'package:darkoff/core/utils/color_utils.dart';
import 'package:darkoff/core/widgets/app_image.dart';
import 'package:darkoff/presentation/features/items/model/item_ui_model.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});

  final ItemUiModel item;

  @override
  Widget build(BuildContext context) {
    final shape = context.shapeTheme;
    return Card(
      elevation: 2,
      shape: shape.shapeSM,
      child: InkWell(
        onTap: () => context.router.push(ItemDetailRoute(itemId: item.id)),
        borderRadius: shape.radiusSM,
        child: SizedBox(
          height: 80,
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: parseHexColor(item.backgroundColor),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(shape.sm),
                  ),
                ),
                child: AppImage(
                  imageUrl: item.highResImageUrl ?? '',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.shortName ?? item.displayName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
