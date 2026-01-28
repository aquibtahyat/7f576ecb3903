class DeviceVitalsRequestModel {
  final String deviceId;
  final String timestamp;
  final int thermalValue;
  final int batteryLevel;
  final int memoryUsage;

  const DeviceVitalsRequestModel({
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
}
