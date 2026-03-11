import 'package:darkoff/domain/entities/item_detail_entity.dart';

class EquipmentPropertiesHelper {
  static Map<String, dynamic>? toJson(ItemProperties props) {
    return switch (props) {
      FoodDrinkProperties p => {
          'type': 'foodDrink',
          'energy': p.energy,
          'hydration': p.hydration,
          'units': p.units,
          'stimEffects': p.stimEffects
              .map((e) => {
                    'type': e.type,
                    'chance': e.chance,
                    'delay': e.delay,
                    'duration': e.duration,
                    'value': e.value,
                    'percent': e.percent,
                    'skillName': e.skillName,
                  })
              .toList(),
        },
      BackpackProperties p => {
          'type': 'backpack',
          'capacity': p.capacity,
          'speedPenalty': p.speedPenalty,
          'turnPenalty': p.turnPenalty,
          'ergoPenalty': p.ergoPenalty,
          'gridsJson': p.gridsJson,
        },
      ContainerProperties p => {
          'type': 'container',
          'capacity': p.capacity,
          'gridsJson': p.gridsJson,
        },
      HeadphoneProperties p => {
          'type': 'headphone',
          'ambientVolume': p.ambientVolume,
          'distortion': p.distortion,
          'distanceModifier': p.distanceModifier,
        },
      KeyProperties p => {
          'type': 'key',
          'uses': p.uses,
        },
      NightVisionProperties p => {
          'type': 'nightVision',
          'intensity': p.intensity,
          'noiseIntensity': p.noiseIntensity,
          'noiseScale': p.noiseScale,
          'diffuseIntensity': p.diffuseIntensity,
        },
      ResourceProperties p => {
          'type': 'resource',
          'units': p.units,
        },
      _ => null,
    };
  }

  static ItemProperties? fromJson(String type, Map<String, dynamic> json) {
    return switch (type) {
      'foodDrink' => FoodDrinkProperties(
          energy: json['energy'] as int?,
          hydration: json['hydration'] as int?,
          units: json['units'] as int?,
          stimEffects: _parseStimEffects(json['stimEffects']),
        ),
      'backpack' => BackpackProperties(
          capacity: json['capacity'] as int?,
          speedPenalty: (json['speedPenalty'] as num?)?.toDouble(),
          turnPenalty: (json['turnPenalty'] as num?)?.toDouble(),
          ergoPenalty: (json['ergoPenalty'] as num?)?.toDouble(),
          gridsJson: json['gridsJson'] as String?,
        ),
      'container' => ContainerProperties(
          capacity: json['capacity'] as int?,
          gridsJson: json['gridsJson'] as String?,
        ),
      'headphone' => HeadphoneProperties(
          ambientVolume: json['ambientVolume'] as int?,
          distortion: (json['distortion'] as num?)?.toDouble(),
          distanceModifier: (json['distanceModifier'] as num?)?.toDouble(),
        ),
      'key' => KeyProperties(uses: json['uses'] as int?),
      'nightVision' => NightVisionProperties(
          intensity: (json['intensity'] as num?)?.toDouble(),
          noiseIntensity: (json['noiseIntensity'] as num?)?.toDouble(),
          noiseScale: (json['noiseScale'] as num?)?.toDouble(),
          diffuseIntensity: (json['diffuseIntensity'] as num?)?.toDouble(),
        ),
      'resource' => ResourceProperties(units: json['units'] as int?),
      _ => null,
    };
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
}
