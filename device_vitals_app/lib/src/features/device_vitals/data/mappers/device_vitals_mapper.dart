import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_entity.dart';

class DeviceVitalsMapper {
  static DeviceVitalsEntity toEntity(DeviceVitalsModel model) {
    return DeviceVitalsEntity(
      timestamp: DateTime.parse(model.timestamp).toLocal(),
      thermalValue: model.thermalValue,
      batteryLevel: model.batteryLevel,
      memoryUsage: model.memoryUsage,
    );
  }

  static List<DeviceVitalsEntity> toEntityList(List<DeviceVitalsModel> list) {
    return list.map((e) => toEntity(e)).toList();
  }
}
