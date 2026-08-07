import 'package:darkoff/core/localization/strings.g.dart';
import 'package:flutter/material.dart';

enum MoreSection {
  tools,
  reference,
  app;

  String get title => switch (this) {
        MoreSection.tools => tr.more.section.tools,
        MoreSection.reference => tr.more.section.reference,
        MoreSection.app => tr.more.section.app,
      };
}

enum MoreMenuEntry {
  ammoChart(MoreSection.tools, Icons.inventory_2_outlined),
  hideout(MoreSection.tools, Icons.home_work_outlined),
  traders(MoreSection.tools, Icons.person_outlined),
  fleaMarket(MoreSection.tools, Icons.storefront_outlined),
  bosses(MoreSection.reference, Icons.shield_outlined),
  keys(MoreSection.reference, Icons.key_outlined),
  crafts(MoreSection.reference, Icons.bar_chart_outlined),
  barters(MoreSection.reference, Icons.swap_horiz_outlined),
  settings(MoreSection.app, Icons.settings_outlined),
  about(MoreSection.app, Icons.info_outline);

  const MoreMenuEntry(this.section, this.icon);

  final MoreSection section;
  final IconData icon;

  String get label => switch (this) {
        MoreMenuEntry.ammoChart => tr.more.item.ammoChart.title,
        MoreMenuEntry.hideout => tr.more.item.hideout.title,
        MoreMenuEntry.traders => tr.more.item.traders.title,
        MoreMenuEntry.fleaMarket => tr.more.item.fleaMarket.title,
        MoreMenuEntry.bosses => tr.more.item.bosses.title,
        MoreMenuEntry.keys => tr.more.item.keys.title,
        MoreMenuEntry.crafts => tr.more.item.crafts.title,
        MoreMenuEntry.barters => tr.more.item.barters.title,
        MoreMenuEntry.settings => tr.more.item.settings.title,
        MoreMenuEntry.about => tr.more.item.about.title,
      };

  String get subtitle => switch (this) {
        MoreMenuEntry.ammoChart => tr.more.item.ammoChart.subtitle,
        MoreMenuEntry.hideout => tr.more.item.hideout.subtitle,
        MoreMenuEntry.traders => tr.more.item.traders.subtitle,
        MoreMenuEntry.fleaMarket => tr.more.item.fleaMarket.subtitle,
        MoreMenuEntry.bosses => tr.more.item.bosses.subtitle,
        MoreMenuEntry.keys => tr.more.item.keys.subtitle,
        MoreMenuEntry.crafts => tr.more.item.crafts.subtitle,
        MoreMenuEntry.barters => tr.more.item.barters.subtitle,
        MoreMenuEntry.settings => tr.more.item.settings.subtitle,
        MoreMenuEntry.about => tr.more.item.about.subtitle,
      };
}

class MoreSectionData {
  const MoreSectionData({required this.section, required this.entries});

  final MoreSection section;
  final List<MoreMenuEntry> entries;
}
