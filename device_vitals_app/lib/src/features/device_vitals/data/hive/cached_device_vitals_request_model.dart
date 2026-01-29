import 'package:device_vitals_app/src/features/device_vitals/data/models/device_vitals_request_model.dart';
import 'package:hive_ce/hive.dart';

part 'cached_device_vitals_request_model.g.dart';

@HiveType(typeId: 0)
class CachedDeviceVitalsRequestModel extends HiveObject {
  @HiveField(0)
  final String deviceId;

  @HiveField(1)
  final String timestamp;

  @HiveField(2)
  final int thermalValue;

  @HiveField(3)
  final int batteryLevel;

  @HiveField(4)
  final int memoryUsage;

  CachedDeviceVitalsRequestModel({
    required this.deviceId,
    required this.timestamp,
    required this.thermalValue,
    required this.batteryLevel,
    required this.memoryUsage,
  });

  Map<String, dynamic> toJson() {
    return {
      'device_id': deviceId,
      'timestamp': timestamp,
      'thermal_value': thermalValue,
      'battery_level': batteryLevel,
      'memory_usage': memoryUsage,
    };
  }

  factory CachedDeviceVitalsRequestModel.fromModel(
    DeviceVitalsRequestModel model,
  ) {
    return CachedDeviceVitalsRequestModel(
      deviceId: model.deviceId,
      timestamp: model.timestamp,
      thermalValue: model.thermalValue,
      batteryLevel: model.batteryLevel,
      memoryUsage: model.memoryUsage,
    );
  }
}
