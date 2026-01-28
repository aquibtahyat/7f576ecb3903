import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_request_model.dart';
import 'package:device_vitals_app/src/features/device_vitals/domain/entities/device_vitals_request_entity.dart';

class DeviceVitalsRequestMapper {
  static DeviceVitalsRequestModel toModel({
    required DeviceVitalsRequestEntity entity,
    required String timestamp,
    required String deviceId,
  }) {
    return DeviceVitalsRequestModel(
      deviceId: deviceId,
      timestamp: timestamp,
      thermalValue: entity.thermalValue,
      batteryLevel: entity.batteryLevel,
      memoryUsage: entity.memoryUsage,
    );
  }
}
