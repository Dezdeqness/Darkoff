import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';

import 'theme/theme.widgetbook.dart';
import 'widgets/inputs/search_bar.widgetbook.dart';
import 'widgets/inputs/chips.widgetbook.dart';
import 'widgets/cards/cards.widgetbook.dart';
import 'widgets/labels/labels.widgetbook.dart';
import 'widgets/badges/badges.widgetbook.dart';
import 'widgets/layout/page_header.widgetbook.dart';
import 'widgets/layout/info_row.widgetbook.dart';
import 'widgets/layout/recipe_item_row.widgetbook.dart';
import 'widgets/media/app_image.widgetbook.dart';
import 'widgets/media/item_icon.widgetbook.dart';
import 'widgets/feedback/empty_states.widgetbook.dart';
import 'widgets/feedback/error_states.widgetbook.dart';
import 'widgets/feedback/progress.widgetbook.dart';
import 'widgets/animation/slide_fade.widgetbook.dart';

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        BuilderAddon(
          name: 'Darkoff Theme',
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              extensions: [
                ...Theme.of(context).extensions.values,
                AppTheme.dark(),
              ],
            ),
            child: Material(
              type: MaterialType.transparency,
              child: child,
            ),
          ),
        ),
        ViewportAddon([
          IosViewports.iPhone13ProMax,
          IosViewports.iPhone13,
          AndroidViewports.samsungGalaxyS20,
          AndroidViewports.samsungGalaxyA50,
        ]),
        InspectorAddon(),
        ZoomAddon(),
        TextScaleAddon(
          initialScale: 1.0,
          min: 0.8,
          max: 2.0,
          divisions: 6,
        ),
        AlignmentAddon(
          initialAlignment: Alignment.center,
        ),
      ],
      directories: [
        themeDirectory,
        WidgetbookCategory(
          name: 'Inputs',
          children: [
            searchBarComponent,
            chipsComponent,
          ],
        ),
        WidgetbookCategory(
          name: 'Cards',
          children: [cardsComponent],
        ),
        WidgetbookCategory(
          name: 'Labels',
          children: [labelsComponent],
        ),
        WidgetbookCategory(
          name: 'Badges',
          children: [badgesComponent],
        ),
        WidgetbookCategory(
          name: 'Layout',
          children: [
            pageHeaderComponent,
            infoRowComponent,
            recipeItemRowComponent,
          ],
        ),
        WidgetbookCategory(
          name: 'Media',
          children: [
            appImageComponent,
            itemIconComponent,
          ],
        ),
        WidgetbookCategory(
          name: 'Feedback',
          children: [
            emptyStatesComponent,
            errorStatesComponent,
            progressComponent,
          ],
        ),
        WidgetbookCategory(
          name: 'Animation',
          children: [slideFadeComponent],
        ),
      ],
    );
  }
}
