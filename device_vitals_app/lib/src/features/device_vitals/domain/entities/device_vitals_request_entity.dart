class DeviceVitalsRequestEntity {
  final int thermalValue;
  final int batteryLevel;
  final int memoryUsage;

  DeviceVitalsRequestEntity({
    required this.thermalValue,
    required this.batteryLevel,
    required this.memoryUsage,
  });
}
