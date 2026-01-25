import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';

class BatteryLevelModel extends BatteryLevelEntity {
  const BatteryLevelModel({super.batteryLevel});

  factory BatteryLevelModel.fromJson(Map<String, dynamic> json) {
    return BatteryLevelModel(batteryLevel: json['battery_level']);
  }
}
