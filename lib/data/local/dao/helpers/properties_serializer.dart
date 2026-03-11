import 'package:darkoff/data/local/dao/helpers/armor_properties_helper.dart';
import 'package:darkoff/data/local/dao/helpers/equipment_properties_helper.dart';
import 'package:darkoff/data/local/dao/helpers/medical_properties_helper.dart';
import 'package:darkoff/data/local/dao/helpers/weapon_properties_helper.dart';
import 'package:darkoff/domain/entities/item_detail_entity.dart';

class PropertiesSerializer {
  static Map<String, dynamic> toJson(ItemProperties props) {
    return WeaponPropertiesHelper.toJson(props) ??
        ArmorPropertiesHelper.toJson(props) ??
        MedicalPropertiesHelper.toJson(props) ??
        EquipmentPropertiesHelper.toJson(props) ??
        {'type': 'unknown'};
  }

  static ItemProperties fromJson(Map<String, dynamic> json) {
    final type = json['type'] as String;
    return WeaponPropertiesHelper.fromJson(type, json) ??
        ArmorPropertiesHelper.fromJson(type, json) ??
        MedicalPropertiesHelper.fromJson(type, json) ??
        EquipmentPropertiesHelper.fromJson(type, json) ??
        const UnknownProperties();
  }
}
