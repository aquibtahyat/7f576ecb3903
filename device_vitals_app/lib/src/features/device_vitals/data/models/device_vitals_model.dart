class DeviceVitalsModel {
  final String timestamp;
  final int thermalValue;
  final int batteryLevel;
  final int memoryUsage;

  const DeviceVitalsModel({
    required this.timestamp,
    required this.thermalValue,
    required this.batteryLevel,
    required this.memoryUsage,
  });

  factory DeviceVitalsModel.fromJson(Map<String, dynamic> json) {
    return DeviceVitalsModel(
      timestamp: json['timestamp'],
      thermalValue: json['thermal_value'],
      batteryLevel: json['battery_level'],
      memoryUsage: json['memory_usage'],
    );
  }
}
