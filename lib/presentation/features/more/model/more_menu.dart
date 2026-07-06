import 'package:flutter/material.dart';

enum MoreSection {
  tools('more.section.tools'),
  reference('more.section.reference'),
  app('more.section.app');

  const MoreSection(this.titleKey);

  final String titleKey;
}

enum MoreMenuEntry {
  ammoChart(MoreSection.tools, Icons.inventory_2_outlined, 'more.item.ammoChart'),
  hideout(MoreSection.tools, Icons.home_work_outlined, 'more.item.hideout'),
  traders(MoreSection.tools, Icons.person_outlined, 'more.item.traders'),
  fleaMarket(MoreSection.tools, Icons.storefront_outlined, 'more.item.fleaMarket'),
  bosses(MoreSection.reference, Icons.shield_outlined, 'more.item.bosses'),
  keys(MoreSection.reference, Icons.key_outlined, 'more.item.keys'),
  crafts(MoreSection.reference, Icons.bar_chart_outlined, 'more.item.crafts'),
  barters(MoreSection.reference, Icons.swap_horiz_outlined, 'more.item.barters'),
  settings(MoreSection.app, Icons.settings_outlined, 'more.item.settings'),
  about(MoreSection.app, Icons.info_outline, 'more.item.about');

  const MoreMenuEntry(this.section, this.icon, this.baseKey);

  final MoreSection section;
  final IconData icon;

  final String baseKey;

  String get labelKey => baseKey;
  String get subtitleKey => '$baseKey.subtitle';
}

class MoreSectionData {
  const MoreSectionData({required this.section, required this.entries});

  final MoreSection section;
  final List<MoreMenuEntry> entries;
}
