import 'package:darkoff/domain/entities/item_detail_entity.dart';

class ArmorPropertiesHelper {
  static Map<String, dynamic>? toJson(ItemProperties props) {
    return switch (props) {
      ArmorProperties p => {
          'type': 'armor',
          'armorClass': p.armorClass,
          'materialId': p.materialId,
          'materialName': p.materialName,
          'zones': p.zones,
          'durability': p.durability,
          'ergoPenalty': p.ergoPenalty,
          'speedPenalty': p.speedPenalty,
          'turnPenalty': p.turnPenalty,
          'armorType': p.armorType,
          'armorSlotsJson': p.armorSlotsJson,
        },
      ArmorAttachmentProperties p => {
          'type': 'armorAttachment',
          'armorClass': p.armorClass,
          'materialId': p.materialId,
          'materialName': p.materialName,
          'zones': p.zones,
          'durability': p.durability,
          'ergoPenalty': p.ergoPenalty,
          'speedPenalty': p.speedPenalty,
          'turnPenalty': p.turnPenalty,
        },
      HelmetProperties p => {
          'type': 'helmet',
          'armorClass': p.armorClass,
          'materialId': p.materialId,
          'materialName': p.materialName,
          'headZones': p.headZones,
          'durability': p.durability,
          'ergoPenalty': p.ergoPenalty,
          'speedPenalty': p.speedPenalty,
          'turnPenalty': p.turnPenalty,
          'deafening': p.deafening,
          'blocksHeadset': p.blocksHeadset,
          'blindnessProtection': p.blindnessProtection,
          'ricochetY': p.ricochetY,
          'slotsJson': p.slotsJson,
          'armorSlotsJson': p.armorSlotsJson,
        },
      ChestRigProperties p => {
          'type': 'chestRig',
          'armorClass': p.armorClass,
          'materialId': p.materialId,
          'materialName': p.materialName,
          'zones': p.zones,
          'durability': p.durability,
          'capacity': p.capacity,
          'ergoPenalty': p.ergoPenalty,
          'speedPenalty': p.speedPenalty,
          'turnPenalty': p.turnPenalty,
          'gridsJson': p.gridsJson,
          'armorSlotsJson': p.armorSlotsJson,
        },
      GlassesProperties p => {
          'type': 'glasses',
          'armorClass': p.armorClass,
          'durability': p.durability,
          'blindnessProtection': p.blindnessProtection,
          'ergoPenalty': p.ergoPenalty,
          'materialId': p.materialId,
          'materialName': p.materialName,
        },
      HeadwearProperties p => {
          'type': 'headwear',
          'slotsJson': p.slotsJson,
        },
      _ => null,
    };
  }

  static ItemProperties? fromJson(String type, Map<String, dynamic> json) {
    return switch (type) {
      'armor' => ArmorProperties(
          armorClass: json['armorClass'] as int?,
          materialId: json['materialId'] as String?,
          materialName: json['materialName'] as String?,
          zones: _stringList(json['zones']),
          durability: json['durability'] as int?,
          ergoPenalty: (json['ergoPenalty'] as num?)?.toDouble(),
          speedPenalty: (json['speedPenalty'] as num?)?.toDouble(),
          turnPenalty: (json['turnPenalty'] as num?)?.toDouble(),
          armorType: json['armorType'] as String?,
          armorSlotsJson: json['armorSlotsJson'] as String?,
        ),
      'armorAttachment' => ArmorAttachmentProperties(
          armorClass: json['armorClass'] as int?,
          materialId: json['materialId'] as String?,
          materialName: json['materialName'] as String?,
          zones: _stringList(json['zones']),
          durability: json['durability'] as int?,
          ergoPenalty: (json['ergoPenalty'] as num?)?.toDouble(),
          speedPenalty: (json['speedPenalty'] as num?)?.toDouble(),
          turnPenalty: (json['turnPenalty'] as num?)?.toDouble(),
        ),
      'helmet' => HelmetProperties(
          armorClass: json['armorClass'] as int?,
          materialId: json['materialId'] as String?,
          materialName: json['materialName'] as String?,
          headZones: _stringList(json['headZones']),
          durability: json['durability'] as int?,
          ergoPenalty: (json['ergoPenalty'] as num?)?.toDouble(),
          speedPenalty: (json['speedPenalty'] as num?)?.toDouble(),
          turnPenalty: (json['turnPenalty'] as num?)?.toDouble(),
          deafening: json['deafening'] as String?,
          blocksHeadset: json['blocksHeadset'] as bool?,
          blindnessProtection:
              (json['blindnessProtection'] as num?)?.toDouble(),
          ricochetY: (json['ricochetY'] as num?)?.toDouble(),
          slotsJson: json['slotsJson'] as String?,
          armorSlotsJson: json['armorSlotsJson'] as String?,
        ),
      'chestRig' => ChestRigProperties(
          armorClass: json['armorClass'] as int?,
          materialId: json['materialId'] as String?,
          materialName: json['materialName'] as String?,
          zones: _stringList(json['zones']),
          durability: json['durability'] as int?,
          capacity: json['capacity'] as int?,
          ergoPenalty: (json['ergoPenalty'] as num?)?.toDouble(),
          speedPenalty: (json['speedPenalty'] as num?)?.toDouble(),
          turnPenalty: (json['turnPenalty'] as num?)?.toDouble(),
          gridsJson: json['gridsJson'] as String?,
          armorSlotsJson: json['armorSlotsJson'] as String?,
        ),
      'glasses' => GlassesProperties(
          armorClass: json['armorClass'] as int?,
          durability: json['durability'] as int?,
          blindnessProtection:
              (json['blindnessProtection'] as num?)?.toDouble(),
          ergoPenalty: (json['ergoPenalty'] as num?)?.toDouble(),
          materialId: json['materialId'] as String?,
          materialName: json['materialName'] as String?,
        ),
      'headwear' => HeadwearProperties(
          slotsJson: json['slotsJson'] as String?,
        ),
      _ => null,
    };
  }

  static List<String> _stringList(dynamic value) {
    if (value == null) return [];
    return (value as List<dynamic>).whereType<String>().toList();
  }
}
