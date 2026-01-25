import 'package:device_vitals_app/src/features/device_vitals/data/models/battery_level_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/battery_level_entity.dart';

class BatteryLevelMapper {
  static BatteryLevelEntity toEntity(BatteryLevelModel model) {
    return BatteryLevelEntity(batteryLevel: model.batteryLevel);
  }
}
