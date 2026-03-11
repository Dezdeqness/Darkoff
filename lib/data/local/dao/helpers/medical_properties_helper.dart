import 'package:darkoff/domain/entities/item_detail_entity.dart';

class MedicalPropertiesHelper {
  static Map<String, dynamic>? toJson(ItemProperties props) {
    return switch (props) {
      MedKitProperties p => {
          'type': 'medKit',
          'hitpoints': p.hitpoints,
          'useTime': p.useTime,
          'maxHealPerUse': p.maxHealPerUse,
          'cures': p.cures,
          'hpCostLightBleeding': p.hpCostLightBleeding,
          'hpCostHeavyBleeding': p.hpCostHeavyBleeding,
        },
      MedicalItemProperties p => {
          'type': 'medicalItem',
          'uses': p.uses,
          'useTime': p.useTime,
          'cures': p.cures,
        },
      PainkillerProperties p => {
          'type': 'painkiller',
          'uses': p.uses,
          'useTime': p.useTime,
          'painkillerDuration': p.painkillerDuration,
          'cures': p.cures,
          'energyImpact': p.energyImpact,
          'hydrationImpact': p.hydrationImpact,
        },
      SurgicalKitProperties p => {
          'type': 'surgicalKit',
          'uses': p.uses,
          'useTime': p.useTime,
          'cures': p.cures,
          'minLimbHealth': p.minLimbHealth,
          'maxLimbHealth': p.maxLimbHealth,
        },
      StimProperties p => {
          'type': 'stim',
          'useTime': p.useTime,
          'cures': p.cures,
          'stimEffects': _stimEffectsToJson(p.stimEffects),
        },
      _ => null,
    };
  }

  static ItemProperties? fromJson(String type, Map<String, dynamic> json) {
    return switch (type) {
      'medKit' => MedKitProperties(
          hitpoints: json['hitpoints'] as int?,
          useTime: json['useTime'] as int?,
          maxHealPerUse: json['maxHealPerUse'] as int?,
          cures: _stringList(json['cures']),
          hpCostLightBleeding: json['hpCostLightBleeding'] as int?,
          hpCostHeavyBleeding: json['hpCostHeavyBleeding'] as int?,
        ),
      'medicalItem' => MedicalItemProperties(
          uses: json['uses'] as int?,
          useTime: json['useTime'] as int?,
          cures: _stringList(json['cures']),
        ),
      'painkiller' => PainkillerProperties(
          uses: json['uses'] as int?,
          useTime: json['useTime'] as int?,
          painkillerDuration:
              (json['painkillerDuration'] as num?)?.toDouble(),
          cures: _stringList(json['cures']),
          energyImpact: json['energyImpact'] as int?,
          hydrationImpact: json['hydrationImpact'] as int?,
        ),
      'surgicalKit' => SurgicalKitProperties(
          uses: json['uses'] as int?,
          useTime: json['useTime'] as int?,
          cures: _stringList(json['cures']),
          minLimbHealth: (json['minLimbHealth'] as num?)?.toDouble(),
          maxLimbHealth: (json['maxLimbHealth'] as num?)?.toDouble(),
        ),
      'stim' => StimProperties(
          useTime: json['useTime'] as int?,
          cures: _stringList(json['cures']),
          stimEffects: _parseStimEffects(json['stimEffects']),
        ),
      _ => null,
    };
  }

  static List<Map<String, dynamic>> _stimEffectsToJson(
      List<StimEffect> effects) {
    return effects
        .map((e) => {
              'type': e.type,
              'chance': e.chance,
              'delay': e.delay,
              'duration': e.duration,
              'value': e.value,
              'percent': e.percent,
              'skillName': e.skillName,
            })
        .toList();
  }

  static List<StimEffect> _parseStimEffects(dynamic value) {
    if (value == null) return [];
    return (value as List<dynamic>)
        .map((e) => StimEffect(
              type: e['type'] as String,
              chance: (e['chance'] as num).toDouble(),
              delay: e['delay'] as int,
              duration: e['duration'] as int,
              value: (e['value'] as num).toDouble(),
              percent: e['percent'] as bool,
              skillName: e['skillName'] as String?,
            ))
        .toList();
  }

  static List<String> _stringList(dynamic value) {
    if (value == null) return [];
    return (value as List<dynamic>).whereType<String>().toList();
  }
}
