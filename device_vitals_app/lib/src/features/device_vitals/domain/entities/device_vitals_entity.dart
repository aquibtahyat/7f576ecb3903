class DeviceVitalsEntity {
  final DateTime timestamp;
  final int thermalValue;
  final int batteryLevel;
  final int memoryUsage;

  const DeviceVitalsEntity({
    required this.timestamp,
    required this.thermalValue,
    required this.batteryLevel,
    required this.memoryUsage,
  });
}
