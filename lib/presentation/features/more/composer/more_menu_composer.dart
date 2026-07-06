import 'package:darkoff/presentation/features/more/model/more_menu.dart';

class MoreMenuComposer {
  const MoreMenuComposer();

  List<MoreSectionData> compose() {
    final bySection = <MoreSection, List<MoreMenuEntry>>{};
    for (final entry in MoreMenuEntry.values) {
      bySection.putIfAbsent(entry.section, () => <MoreMenuEntry>[]).add(entry);
    }

    final sectionsData = <MoreSectionData>[];

    for (final section in MoreSection.values) {
      final entries = bySection[section];
      if (entries != null && entries.isNotEmpty) {
        sectionsData.add(MoreSectionData(section: section, entries: entries));
      }
    }

    return sectionsData;
  }
}
