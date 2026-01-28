class DeviceVitalsRequestParams {
  final int thermalValue;
  final int batteryLevel;
  final int memoryUsage;
  final DateTime? timestamp;

  DeviceVitalsRequestParams({
    required this.thermalValue,
    required this.batteryLevel,
    required this.memoryUsage,
    this.timestamp,
  });
}
