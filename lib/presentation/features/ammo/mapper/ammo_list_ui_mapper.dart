import 'package:darkoff/core/localization/strings.g.dart';
import 'package:darkoff/domain/entities/ammo_entity.dart';
import 'package:darkoff/presentation/features/ammo/model/ammo_list_ui_model.dart';

class AmmoListUiMapper {
  AmmoListUiModel build(
    List<AmmoEntity> ammo, {
    String? selectedCaliber,
    String search = '',
    bool sortByPen = true,
  }) {
    final calibers = _calibers(ammo);
    final filtered = _filterAndSort(
      ammo,
      selectedCaliber: selectedCaliber,
      search: search,
      sortByPen: sortByPen,
    );

    final grouped = selectedCaliber == null && search.isEmpty;

    return AmmoListUiModel(
      calibers: calibers,
      selectedCaliber: selectedCaliber,
      sortLabel: sortByPen ? 'Penetration ↓' : 'Damage ↓',
      grouped: grouped,
      groups: grouped ? _groups(filtered) : const [],
      rows: grouped
          ? const []
          : filtered
                .map(
                  (a) => _row(
                    a,
                    trailing: search.isNotEmpty
                        ? _prettyCaliber(a.caliber ?? '')
                        : '',
                  ),
                )
                .toList(),
    );
  }

  List<AmmoCaliberOption> _calibers(List<AmmoEntity> ammo) {
    final set = <String>{};
    for (final a in ammo) {
      if (a.caliber != null) set.add(a.caliber!);
    }
    return set
        .map((v) => AmmoCaliberOption(value: v, label: _prettyCaliber(v)))
        .toList()
      ..sort((a, b) => a.label.compareTo(b.label));
  }

  String _prettyCaliber(String raw) {
    const names = <String, String>{
      'Caliber9x18PM': '9x18 PM',
      'Caliber9x18PMM': '9x18 PMM',
      'Caliber9x19PARA': '9x19',
      'Caliber9x21': '9x21',
      'Caliber762x25TT': '7.62x25 TT',
      'Caliber1143x23ACP': '.45 ACP',
      'Caliber46x30': '4.6x30',
      'Caliber57x28': '5.7x28',
      'Caliber9x39': '9x39',
      'Caliber366TKM': '.366 TKM',
      'Caliber545x39': '5.45x39',
      'Caliber556x45NATO': '5.56x45',
      'Caliber762x35': '.300 BLK',
      'Caliber762x39': '7.62x39',
      'Caliber762x51': '7.62x51',
      'Caliber762x54R': '7.62x54R',
      'Caliber68x51': '6.8x51',
      'Caliber86x70': '.338 LM',
      'Caliber127x55': '12.7x55',
      'Caliber127x108': '12.7x108',
      'Caliber12g': '12/70',
      'Caliber20g': '20/70',
      'Caliber23x75': '23x75mm',
      'Caliber26x75': '26x75mm',
      'Caliber30x29': '30x29mm',
      'Caliber40x46': '40x46mm',
      'Caliber40mmRU': '40mm VOG',
    };
    return names[raw] ??
        (raw.startsWith('Caliber') ? raw.substring('Caliber'.length) : raw);
  }

  List<AmmoEntity> _filterAndSort(
    List<AmmoEntity> ammo, {
    required String? selectedCaliber,
    required String search,
    required bool sortByPen,
  }) {
    final query = search.toLowerCase();

    final list = ammo.where((a) {
      if (selectedCaliber != null && a.caliber != selectedCaliber) {
        return false;
      }
      if (query.isNotEmpty) {
        return a.shortName.toLowerCase().contains(query) ||
            (a.caliber?.toLowerCase().contains(query) ?? false);
      }
      return true;
    }).toList();

    list.sort(
      (a, b) => sortByPen
          ? b.penetrationPower.compareTo(a.penetrationPower)
          : b.damage.compareTo(a.damage),
    );

    return list;
  }

  List<AmmoGroupUiModel> _groups(List<AmmoEntity> ammo) {
    final grouped = <String, List<AmmoEntity>>{};
    for (final a in ammo) {
      grouped.putIfAbsent(a.caliber ?? tr.common.value.unknown, () => []).add(a);
    }

    final keys = grouped.keys.toList()..sort();
    return [
      for (final key in keys)
        AmmoGroupUiModel(
          caliberLabel: _prettyCaliber(key).toUpperCase(),
          rows: grouped[key]!.map(_row).toList(),
        ),
    ];
  }

  AmmoRowUiModel _row(AmmoEntity ammo, {String trailing = ''}) =>
      AmmoRowUiModel(
        id: ammo.id,
        shortName: ammo.shortName,
        damage: '${ammo.damage}',
        penetration: '${ammo.penetrationPower}',
        trailingLabel: trailing,
        penTier: _penTier(ammo.penetrationPower),
        tracer: ammo.tracer,
      );

  AmmoPenTier _penTier(int penetration) {
    if (penetration >= 40) return AmmoPenTier.high;
    if (penetration >= 25) return AmmoPenTier.mid;
    return AmmoPenTier.low;
  }
}
